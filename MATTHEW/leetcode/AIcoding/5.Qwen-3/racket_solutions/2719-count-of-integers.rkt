(define (count-integers n)
  (define (helper x)
    (if (< x 10)
        1
        (+ (helper (quotient x 10)) 1)))
  (define (count x)
    (if (= x 0)
        0
        (+ (count (quotient x 10)) 1)))
  (if (< n 10)
      1
      (+ (count n) 1)))