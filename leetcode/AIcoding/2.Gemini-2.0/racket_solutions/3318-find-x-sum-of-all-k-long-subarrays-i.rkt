(define (k-sum-subarray-sums nums k)
  (let* ((n (length nums))
         (sums (make-vector (max 0 (- n k -1)) 0)))
    (if (or (zero? n) (< n k))
        0
        (begin
          (for ((i (in-range (- n k -1))))
            (vector-set! sums i
                         (foldl + 0 (take (drop nums i) k))))
          (foldl + 0 (vector->list sums))))))