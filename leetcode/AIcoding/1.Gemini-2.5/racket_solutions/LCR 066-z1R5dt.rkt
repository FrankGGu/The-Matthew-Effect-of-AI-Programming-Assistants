#lang racket

(struct trie-node (children prefix-sum) #:mutable)

(struct map-sum (root key-values) #:mutable)

(define (map-sum-init)
  (map-sum (trie-node (make-hash) 0) (make-hash)))

(define (map-sum-insert this key val)
  (define old-val (hash-ref (map-sum-key-values this) key 0))
  (hash-set! (map-sum-key-values this) key val)
  (define diff (- val old-val))

  (define curr (map-sum-root this))
  (for ([c (in-string key)])
    (set-trie-node-prefix-sum! curr (+ (trie-node-prefix-sum curr) diff))
    (define next-node (hash-ref (trie-node-children curr) c #f))
    (when (not next-node)
      (set! next-node (trie-node (make-hash) 0))
      (hash-set! (trie-node-children curr) c next-node))
    (set! curr next-node))
  (set-trie-node-prefix-sum! curr (+ (trie-node-prefix-sum curr) diff)))

(define (map-sum-sum this prefix)
  (define curr (map-sum-root this))
  (for ([c (in-string prefix)])
    (define next-node (hash-ref (trie-node-children curr) c #f))
    (when (not next-node)
      (set! curr #f)
      (break))
    (set! curr next-node))

  (if curr
      (trie-node-prefix-sum curr)
      0))