(define (maxScore nums)
  (define n (length nums))
  (define dp (make-vector n 0))
  (vector-set! dp 0 (vector-ref nums 0))
  (for ([i (in-range 1 n)])
    (vector-set! dp i (max (vector-ref dp (- i 1)) (+ (vector-ref dp (- i 1)) (vector-ref nums i)))))
  (vector-ref dp (- n 1)))

(maxScore '(1 2 3 4 5))