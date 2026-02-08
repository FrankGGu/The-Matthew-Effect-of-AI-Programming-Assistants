(define (max-sum-of-k-subarrays nums k m)
  (define n (length nums))
  (define max-sum 0)
  (define dp (make-vector (+ n 1) 0))
  (define prefix-sum (make-vector (+ n 1) 0))

  (for ((i (in-range n)))
    (vector-set! prefix-sum (+ i 1) (+ (vector-ref prefix-sum i) (vector-ref nums i))))

  (for ((i (in-range m n)))
    (set! max-sum (max max-sum (- (vector-ref prefix-sum i) (vector-ref prefix-sum (- i m))))))
    (for ((j (in-range i m)))
      (set! dp (vector-set! dp (+ j m) (max (vector-ref dp (+ j m)) (max-sum (+ (vector-ref prefix-sum i) (vector-ref dp j))))))))

  (for ((i (in-range n)))
    (set! max-sum (max max-sum (vector-ref dp (+ i m)))))

  max-sum)

(define (sum-of-k_subarrays nums k m)
  (if (or (< (length nums) m) (< k 1))
      0
      (max-sum-of-k-subarrays nums k m)))