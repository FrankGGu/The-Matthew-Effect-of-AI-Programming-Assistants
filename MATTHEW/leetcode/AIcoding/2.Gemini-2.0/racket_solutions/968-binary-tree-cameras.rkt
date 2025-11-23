(provide solve)

(define (solve root)
  (define (dfs node)
    (cond
      [(null? node) (values 2 0)]
      [else
       (define-values (left-state left-cameras) (dfs (car node)))
       (define-values (right-state right-cameras) (dfs (cadr node)))
       (cond
         [(= left-state 0)
          (values 1 (+ 1 left-cameras right-cameras))]
         [(= right-state 0)
          (values 1 (+ 1 left-cameras right-cameras))]
         [(= left-state 1)
          (values 2 (+ left-cameras right-cameras))]
         [(= right-state 1)
          (values 2 (+ left-cameras right-cameras))]
         [else
          (values 0 (+ left-cameras right-cameras))])]))
    )

  (define-values (root-state cameras) (dfs root))
  (if (= root-state 0)
      (+ cameras 1)
      cameras))