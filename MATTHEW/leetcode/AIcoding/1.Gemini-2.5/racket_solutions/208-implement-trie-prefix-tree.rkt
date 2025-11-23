(define (Trie)
  (struct trie-node (children is-end-of-word) #:mutable)

  (define root (trie-node (make-hash) #f))

  (define (insert word)
    (let loop ((node root) (idx 0))
      (if (= idx (string-length word))
        (set-trie-node-is-end-of-word! node #t)
        (let* ((char (string-ref word idx))
               (children (trie-node-children node))
               (next-node (hash-ref children char #f)))
          (unless next-node
            (set! next-node (trie-node (make-hash) #f))
            (hash-set! children char next-node))
          (loop next-node (+ idx 1))))))

  (define (search word)
    (let loop ((node root) (idx 0))
      (if (= idx (string-length word))
        (trie-node-is-end-of-word node)
        (let* ((char (string-ref word idx))
               (children (trie-node-children node))
               (next-node (hash-ref children char #f)))
          (if next-node
            (loop next-node (+ idx 1))
            #f)))))

  (define (startsWith prefix)
    (let loop ((node root) (idx 0))
      (if (= idx (string-length prefix))
        #t
        (let* ((char (string-ref prefix idx))
               (children (trie-node-children node))
               (next-node (hash-ref children char #f)))
          (if next-node
            (loop next-node (+ idx 1))
            #f)))))

  (hash 'insert insert 'search search 'startsWith startsWith))