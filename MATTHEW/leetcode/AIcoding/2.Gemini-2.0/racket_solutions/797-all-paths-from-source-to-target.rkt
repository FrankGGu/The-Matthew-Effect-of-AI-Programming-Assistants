(define (all-paths-source-target graph)
  (define target (sub1 (vector-length graph)))

  (define (dfs current-node path)
    (if (= current-node target)
        (list (append path (list current-node)))
        (let ([neighbors (vector-ref graph current-node)])
          (if (null? neighbors)
              '()
              (apply append (map (lambda (neighbor) (dfs neighbor (append path (list current-node)))) neighbors))))))

  (dfs 0 '()))