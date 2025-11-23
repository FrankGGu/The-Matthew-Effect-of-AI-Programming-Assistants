(define (max-sum-divisible-k nums k)
  (define n (length nums))
  (define dp (make-vector n 0))
  (define max-sum 0)

  (for ([i (in-range n)])
    (set! (vector-ref dp i) (if (= i 0) (vector-ref nums 0) (+ (vector-ref dp (- i 1)) (vector-ref nums i)))))
    (when (>= i k)
      (define current-sum (vector-ref dp i))
      (when (>= i k)
        (set! max-sum (max max-sum current-sum)))
      (set! (vector-ref dp (- i k)) 0)))

  max-sum)

(define (maxSubarraySumK nums k)
  (max-sum-divisible-k nums k))