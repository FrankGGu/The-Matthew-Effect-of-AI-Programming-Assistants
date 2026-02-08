(struct trie-node (children min-idx) #:mutable)

(define (longest-common-suffix-queries words queries)
  (define root (make-trie-node (hash) +inf.0))

  (define (insert-word! word-str word-idx)
    (define current-node root)
    (set-trie-node-min-idx! current-node (min (trie-node-min-idx current-node) word-idx))
    (for ([char (string->list (string-reverse word-str))])
      (define children-map (trie-node-children current-node))
      (define next-node (hash-ref children-map char #f))
      (unless next-node
        (set! next-node (make-trie-node (hash) +inf.0))
        (hash-set! children-map char next-node))
      (set-trie-node-min-idx! next-node (min (trie-node-min-idx next-node) word-idx))
      (set! current-node next-node)))

  (for ([word words] [idx (in-naturals)])
    (insert-word! word idx))

  (define (process-query query-str)
    (define current-node root)
    (define max-suffix-len 0)
    (define best-word-idx -1)

    (define reversed-query (string-reverse query-str))
    (define query-len (string-length reversed-query))

    (for ([i (in-range query-len)]
          [char (string->list reversed-query)])
      (define children-map (trie-node-children current-node))
      (define next-node (hash-ref children-map char #f))

      (when next-node
        (set! current-node next-node)
        (define node-min-idx (trie-node-min-idx current-node))

        (unless (= node-min-idx +inf.0)
          (define current-suffix-len (+ i 1))

          (cond
            [(> current-suffix-len max-suffix-len)
             (set! max-suffix-len current-suffix-len)
             (set! best-word-idx node-min-idx)]
            [(= current-suffix-len max-suffix-len)
             (when (or (= best-word-idx -1) (< node-min-idx best-word-idx))
               (set! best-word-idx node-min-idx))])))
      (unless next-node
        (break)))

    best-word-idx)

  (map process-query queries))