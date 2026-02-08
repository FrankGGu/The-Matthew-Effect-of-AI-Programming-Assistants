(define (power-of-subarrays nums k)
  (let loop ([i 0] [total 0])
    (if (> i (- (length nums) k))
        total
        (let ([sub-array (subvector nums i (+ i k))])
          (loop (+ i 1) (+ total (apply * sub-array)))))))