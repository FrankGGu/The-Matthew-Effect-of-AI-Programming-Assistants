(define (increasing-triplet nums)
  (let loop ((min1 +inf.0)
             (min2 +inf.0)
             (idx 0))
    (if (>= idx (vector-length nums))
        #f
        (let ((n (vector-ref nums idx)))
          (cond
            ((<= n min1)
             (loop n min2 (+ idx 1)))
            ((<= n min2)
             (loop min1 n (+ idx 1)))
            (else
             #t))))))