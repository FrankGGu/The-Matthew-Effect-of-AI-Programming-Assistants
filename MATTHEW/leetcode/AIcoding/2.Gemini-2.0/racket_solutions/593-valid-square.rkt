(define (valid-square p1 p2 p3 p4)
  (define (dist p1 p2)
    (sqrt (+ (sqr (- (car p1) (car p2))) (sqr (- (cdr p1) (cdr p2))))))

  (define distances (list (dist p1 p2) (dist p1 p3) (dist p1 p4) (dist p2 p3) (dist p2 p4) (dist p3 p4)))

  (define positive-distances (filter (lambda (x) (> x 0)) distances))

  (if (< (length positive-distances) 6)
      #f
      (let* ((sorted-distances (sort positive-distances <))
             (side (car sorted-distances))
             (diag (car (drop sorted-distances 4))))

        (and (= side (list-ref sorted-distances 1))
             (= side (list-ref sorted-distances 2))
             (= side (list-ref sorted-distances 3))
             (= diag (list-ref sorted-distances 5))
             (equal? (* side (sqrt 2)) diag)))))