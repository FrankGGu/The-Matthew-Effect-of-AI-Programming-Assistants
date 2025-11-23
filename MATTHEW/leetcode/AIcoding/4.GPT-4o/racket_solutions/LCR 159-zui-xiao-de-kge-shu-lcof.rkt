(define (get-maximum-amount products)
  (define (helper products k)
    (if (null? products)
        0
        (let* ((product (car products))
               (take (min (car product) k))
               (remain (cdr product))
               (take-amount (+ take (helper remain k))))
          (max take-amount (helper (cdr products) k)))))
  (helper products 1))

(define (maxProfit products)
  (get-maximum-amount products))

(maxProfit '((2 5) (3 7) (5 10)))