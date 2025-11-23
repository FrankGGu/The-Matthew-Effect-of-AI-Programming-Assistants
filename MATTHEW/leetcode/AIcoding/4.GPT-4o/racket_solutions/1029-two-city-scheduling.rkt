(define (twoCitySchedCost costs)
  (define sorted-costs (sort costs (lambda (a b) (< (- (car a) (cadr a)) (- (car b) (cadr b)))))
  (define n (/ (length costs) 2))
  (define total-cost
    (foldl (lambda (x y)
              (if (< (index-of sorted-costs y) n)
                  (+ x (car y))
                  (+ x (cadr y))))
            0
            (take sorted-costs (* 2 n))))
  total-cost)