(define (max-alternating-sum nums)
  (define n (length nums))
  (define dp (make-vector n 0))
  (vector-set! dp 0 (car nums))
  (for ([i (in-range 1 n)])
    (vector-set! dp i (max (vector-ref dp (- i 1)) (if (even? i) (+ (vector-ref dp (- i 1)) (vector-ref nums i)) (vector-ref nums i)))))
  (vector-ref dp (- n 1)))

(max-alternating-sum nums)