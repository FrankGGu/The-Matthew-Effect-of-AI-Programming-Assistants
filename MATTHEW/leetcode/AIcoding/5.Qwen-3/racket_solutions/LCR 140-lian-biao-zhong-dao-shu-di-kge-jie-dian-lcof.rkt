(define (trainning-plan-II n)
  (define (helper i res)
    (if (> i n)
        res
        (helper (+ i 1) (cons (* i i) res))))
  (reverse (helper 1 '())))