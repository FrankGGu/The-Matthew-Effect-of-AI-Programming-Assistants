(define (k-items-with-maximum-sum k ones zeros)
  (max 0 (min k (+ ones (- zeros)))))