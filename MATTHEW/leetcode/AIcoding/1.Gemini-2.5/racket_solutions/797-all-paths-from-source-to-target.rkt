(define (all-paths-source-target graph)
  (let* ((n (length graph))
         (target-node (- n 1)))

    (define (dfs u current-path)
      (if (= u target-node)
          (list (reverse (cons u current-path)))
          (apply append
                 (map (lambda (v)
                        (dfs v (cons u current-path)))
                      (list-ref graph u)))))

    (dfs 0 '())))