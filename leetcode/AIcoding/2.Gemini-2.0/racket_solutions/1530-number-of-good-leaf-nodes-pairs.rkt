(define (count-good-leaf-node-pairs root distance)
  (letrec ((dfs (lambda (node)
                     (cond
                       [(null? node) '()]
                       [(and (null? (struct-ref node 0)) (null? (struct-ref node 1))) (list 0)]
                       [else
                        (let* ((left (dfs (struct-ref node 0)))
                               (right (dfs (struct-ref node 1))))
                          (append (map (lambda (x) (+ x 1)) left) (map (lambda (x) (+ x 1)) right)))])))
           (count-pairs (lambda (left right distance)
                          (let ((valid-left (filter (lambda (x) (<= x distance)) left))
                                (valid-right (filter (lambda (x) (<= x distance)) right)))
                            (length (apply append (map (lambda (l) (map (lambda (r) (+ l r)) valid-right)) valid-left))))))
    (letrec ((helper (lambda (node)
                        (cond
                          [(null? node) (values '() 0)]
                          [(and (null? (struct-ref node 0)) (null? (struct-ref node 1))) (values (list 0) 0)]
                          [else
                           (let* ((left-res (helper (struct-ref node 0)))
                                  (right-res (helper (struct-ref node 1)))
                                  (left-dist (car (multiple-value-list left-res)))
                                  (left-count (cadr (multiple-value-list left-res)))
                                  (right-dist (car (multiple-value-list right-res)))
                                  (right-count (cadr (multiple-value-list right-res)))
                                  (new-dist (append (map (lambda (x) (+ x 1)) left-dist) (map (lambda (x) (+ x 1)) right-dist)))
                             (values new-dist (+ left-count right-count (count-pairs left-dist right-dist distance))))])))))
      (cadr (multiple-value-list (helper root))))))