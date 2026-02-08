(define (minMoneyRequired transactions)
  (define (helper t)
    (foldl (lambda (x acc)
             (if (>= x 0) acc (+ acc (- x))))
           0
           t))
  (max 0 (helper transactions)))