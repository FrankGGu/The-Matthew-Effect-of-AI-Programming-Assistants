(define (maximumTastiness candyPrice k)
  (define (canDistribute mid)
    (define (helper prices remaining)
      (if (or (null? prices) (zero? remaining))
          (zero? remaining)
          (if (>= (car prices) mid)
              (helper (cdr prices) (sub1 remaining))
              (helper (cdr prices) remaining))))
    (helper (sort < candyPrice) k))

  (define (binarySearch low high)
    (if (>= low high)
        low
        (let* ((mid (quotient (+ low high) 2)))
          (if (canDistribute mid)
              (binarySearch mid high)
              (binarySearch low mid)))))

  (binarySearch 0 (apply max candyPrice))
)

(maximumTastiness '(1 3 5 7) 3)