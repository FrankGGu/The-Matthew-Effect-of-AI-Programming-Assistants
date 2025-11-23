#lang racket
(require racket/hash)

(struct trie-node (children count) #:mutable)

(define (build-trie words)
  (define root (trie-node (make-hash) 0))
  (for-each
   (lambda (word)
     (define current root)
     (for-each
      (lambda (char)
        (define next-node (hash-ref (trie-node-children current) char #f))
        (unless next-node
          (set! next-node (trie-node (make-hash) 0))
          (hash-set! (trie-node-children current) char next-node))
        (set! current next-node)
        (set-trie-node-count! current (+ (trie-node-count current) 1)))
      (string->list word)))
   words)
  root)

(define (get-scores root words)
  (define result-scores '())
  (for-each
   (lambda (word)
     (define current root)
     (define current-word-score 0)
     (for-each
      (lambda (char)
        (set! current (hash-ref (trie-node-children current) char))
        (set! current-word-score (+ current-word-score (trie-node-count current))))
      (string->list word))
     (set! result-scores (cons current-word-score result-scores)))
   words)
  (reverse result-scores))

(define (sum-prefix-scores words)
  (define trie-root (build-trie words))
  (get-scores trie-root words))