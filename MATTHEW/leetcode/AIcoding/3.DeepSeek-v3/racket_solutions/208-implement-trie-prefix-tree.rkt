(struct trie-node (children is-end)
  #:mutable)

(define (make-trie-node)
  (trie-node (make-hash) #f))

(define trie%
  (class object%
    (super-new)
    (init-field [root (make-trie-node)])

    (define/public (insert word)
      (let loop ([node root] [i 0])
        (if (= i (string-length word))
            (set-trie-node-is-end! node #t)
            (let ([c (string-ref word i)])
              (unless (hash-has-key? (trie-node-children node) c)
                (hash-set! (trie-node-children node) c (make-trie-node)))
              (loop (hash-ref (trie-node-children node) c) (+ i 1))))))

    (define/public (search word)
      (let loop ([node root] [i 0])
        (if (= i (string-length word))
            (trie-node-is-end node)
            (let ([c (string-ref word i)])
              (if (hash-has-key? (trie-node-children node) c)
                  (loop (hash-ref (trie-node-children node) c) (+ i 1))
                  #f)))))

    (define/public (startsWith prefix)
      (let loop ([node root] [i 0])
        (if (= i (string-length prefix))
            #t
            (let ([c (string-ref prefix i)])
              (if (hash-has-key? (trie-node-children node) c)
                  (loop (hash-ref (trie-node-children node) c) (+ i 1))
                  #f))))))