(define (all-paths-source-target graph)
  (define n (vector-length graph))
  (define paths '())

  (define (dfs current-node current-path)
    (if (= current-node (- n 1))
        (set! paths (cons (append current-path (list current-node)) paths))
        (for-each (lambda (neighbor)
                    (dfs neighbor (append current-path (list current-node))))
                  (vector-ref graph current-node))))

  (dfs 0 '())
  paths)