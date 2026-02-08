#lang racket

(define-struct trie-node (children total-sum) #:mutable)
(define-struct map-sum (root key-values) #:mutable)

(define (map-sum-init)
  (make-map-sum (make-trie-node (make-hash) 0) (make-hash)))

(define (map-sum-insert this key val)
  (let* ([old-val (hash-ref (map-sum-key-values this) key 0)]
         [diff (- val old-val)])
    (hash-set! (map-sum-key-values this) key val)
    (let loop ([current-node (map-sum-root this)]
               [chars (string->list key)])
      (unless (null? chars)
        (let* ([char (car chars)]
               [children (trie-node-children current-node)]
               [next-node (hash-ref children char #f)])
          (unless next-node
            (set! next-node (make-trie-node (make-hash) 0))
            (hash-set! children char next-node))
          (set-trie-node-total-sum! next-node (+ (trie-node-total-sum next-node) diff))
          (loop next-node (cdr chars)))))))

(define (map-sum-sum this prefix)
  (let loop ([current-node (map-sum-root this)]
             [chars (string->list prefix)])
    (if (null? chars)
        (trie-node-total-sum current-node)
        (let* ([char (car chars)]
               [children (trie-node-children current-node)]
               [next-node (hash-ref children char #f)])
          (if next-node
              (loop next-node (cdr chars))
              0)))))