(define (reach-a-number target)
  (define (helper n sum)
    (if (>= sum target)
        (if (even? (- sum target)) n (add1 n))
        (helper (add1 n) (+ sum n))))
  (helper 0 0))

(reach-a-number (abs target))