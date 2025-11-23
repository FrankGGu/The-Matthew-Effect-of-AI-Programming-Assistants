(define (maximum-subarray-sum-with-one-deletion nums)
  (define n (length nums))
  (define max-sum (apply max nums))
  (define dp (make-vector n 0))
  (define dp-delete (make-vector n 0))

  (vector-set! dp 0 (car nums))
  (vector-set! dp-delete 0 0)

  (for ([i (in-range 1 n)])
    (vector-set! dp i (max (vector-ref dp (- i 1)) 0 (+ (vector-ref dp (- i 1)) (vector-ref nums i))))
    (vector-set! dp-delete i (max (vector-ref dp-delete (- i 1)) (+ (vector-ref dp (- i 1)) (vector-ref nums i)))))

  (apply max (vector->list dp) (vector->list dp-delete)))

(maximum-subarray-sum-with-one-deletion (vector 1 -2 0 9)) ; Example test case