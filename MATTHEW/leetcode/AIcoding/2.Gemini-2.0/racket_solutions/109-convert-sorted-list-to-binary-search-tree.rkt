(define (sorted-list-to-bst head)
  (define (list-length head)
    (if (null? head)
        0
        (+ 1 (list-length (cdr head)))))

  (define (build-tree head n)
    (cond
      [(= n 0) (values null head)]
      [else
       (define left-size (floor (/ n 2)))
       (define-values (left-tree remaining-head) (build-tree head left-size))
       (define root-val (car remaining-head))
       (define new-head (cdr remaining-head))
       (define-values (right-tree new-remaining-head) (build-tree new-head (- n left-size 1)))
       (values (cons root-val (list left-tree right-tree)) new-remaining-head)]))

  (define len (list-length head))
  (define-values (tree _) (build-tree head len))
  tree)