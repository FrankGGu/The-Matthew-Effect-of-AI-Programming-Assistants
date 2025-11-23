(define (max-sum-bst root)
  (define (dfs node)
    (if (null? node)
        (values #t 0 -inf.0)
        (let-values (((left-bst? left-sum left-max) (dfs (car node)))
                     ((right-bst? right-sum right-min) (dfs (cadr node))))
          (let* ((value (caddr node))
                 (is-bst? (and left-bst? right-bst? 
                               (< left-max value) 
                               (> right-min value)))
                 (current-sum (if is-bst? (+ left-sum right-sum value) 0)))
            (values is-bst? current-sum 
                    (if is-bst? (max left-max right-max value) -inf.0))))))

  (define (helper node)
    (define-values (is-bst sum max-value) (dfs node))
    (if is-bst 
        sum 
        0))

  (define (traverse node)
    (if (null? node)
        0
        (max (helper node)
             (max (traverse (car node)) (traverse (cadr node))))))

  (traverse root))