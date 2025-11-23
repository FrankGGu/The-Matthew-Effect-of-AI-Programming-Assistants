(struct trie-node (children is-end) #:mutable)
(define (make-trie-node)
  (trie-node (make-hash) #f))

(define word-dictionary%
  (class object%
    (super-new)
    (init-field [root (make-trie-node)])

    (define/public (add-word word)
      (let loop ([node root] [i 0])
        (if (= i (string-length word))
            (set-trie-node-is-end! node #t)
            (let ([c (string-ref word i)])
              (unless (hash-has-key? (trie-node-children node) c)
                (hash-set! (trie-node-children node) c (make-trie-node)))
              (loop (hash-ref (trie-node-children node) c) (+ i 1))))))

    (define/public (search word)
      (define (dfs node i)
        (cond
          [(= i (string-length word)) (trie-node-is-end node)]
          [else
           (let ([c (string-ref word i)])
             (if (char=? c #\.)
                 (for/or ([child (in-hash-values (trie-node-children node))])
                   (dfs child (+ i 1)))
                 (and (hash-has-key? (trie-node-children node) c)
                      (dfs (hash-ref (trie-node-children node) c) (+ i 1))))))]))
      (dfs root 0))))