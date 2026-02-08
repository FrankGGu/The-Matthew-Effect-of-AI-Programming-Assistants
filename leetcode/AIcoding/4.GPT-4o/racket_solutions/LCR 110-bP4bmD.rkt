(define (allPathsSourceTarget graph)
  (define (dfs node path)
    (if (= node (sub1 (length graph)))
        (list (append path (list node)))
        (apply append 
               (map (lambda (next) (dfs next (append path (list node))))
                    (vector->list (list-ref graph node))))))
  (dfs 0 '()))