#lang racket

(struct trie-node (children #:mutable max-idx))

(define (word-filter-init words)
  (define root (trie-node (make-hash) -1))

  (for ([word words] [idx (in-naturals)])
    (define word-len (string-length word))

    (for ([p-len (range (add1 word-len))])
      (define prefix (substring word 0 p-len))
      (for ([s-start (range (add1 word-len))])
        (define suffix (substring word s-start word-len))
        (define key (string-append suffix "#" prefix))

        (define current-node root)
        (for ([char (in-list (string->list key))])
          (define next-node (hash-ref (trie-node-children current-node) char #f))
          (unless next-node
            (set! next-node (trie-node (make-hash) -1))
            (hash-set! (trie-node-children current-node) char next-node))

          (set-trie-node-max-idx! next-node (max (trie-node-max-idx next-node) idx))

          (set! current-node next-node))))))

  (struct word-filter (trie-root))
  (word-filter root))

(define (word-filter-f this prefix suffix)
  (define key (string-append suffix "#" prefix))
  (define current-node (word-filter-trie-root this))

  (for ([char (in-list (string->list key))])
    (define next-node (hash-ref (trie-node-children current-node) char #f))
    (unless next-node
      (set! current-node #f)
      (break))
    (set! current-node next-node))

  (if current-node
      (trie-node-max-idx current-node)
      -1))