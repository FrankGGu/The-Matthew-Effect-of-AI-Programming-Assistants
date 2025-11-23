(define (smallest-subtree-with-all-the-deepest-nodes root)
  (define (depth node)
    (if (null? node)
        0
        (+ 1 (max (depth (car node)) (depth (cadr node))))))

  (define (subtree-with-deepest node)
    (cond
      [(null? node) (values null 0)]
      [else
       (define-values (left-node left-depth) (subtree-with-deepest (car node)))
       (define-values (right-node right-depth) (subtree-with-deepest (cadr node)))
       (cond
         [(= left-depth right-depth) (values node (+ 1 left-depth))]
         [(> left-depth right-depth) (values left-node (+ 1 left-depth))]
         [else (values right-node (+ 1 right-depth))])]))

  (define-values (result _) (subtree-with-deepest root))
  result)