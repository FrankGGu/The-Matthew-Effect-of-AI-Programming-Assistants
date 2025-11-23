(define (deepest-leaves-sum root)
  (letrec (
           (max-depth (lambda (node depth)
                        (cond
                          ((null? node) depth)
                          (else (max (max-depth (car node) (+ 1 depth))
                                     (max-depth (cdr node) (+ 1 depth)))))))
           (sum-at-depth (lambda (node depth target-depth)
                           (cond
                             ((null? node) 0)
                             ((and (null? (car node)) (null? (cdr node)) (= depth target-depth)) node)
                             ((= depth target-depth) 0)
                             (else (+ (sum-at-depth (car node) (+ 1 depth) target-depth)
                                      (sum-at-depth (cdr node) (+ 1 depth) target-depth))))))
           (tree-sum (lambda (node)
                       (cond
                         ((null? node) 0)
                         (else (+ (tree-sum (car node))
                                  (tree-sum (cdr node))
                                  (if (and (null? (car node)) (null? (cdr node))) node 0))))))

    (let ((depth (max-depth root 0)))
      (tree-sum (sum-at-depth root 0 depth)))))