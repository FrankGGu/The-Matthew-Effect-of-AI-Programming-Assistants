(define (special-array nums)
  (let ((n (length nums)))
    (for/first ([k (in-range 1 (add1 n))]
                #:when (= k (length (filter (lambda (x) (>= x k)) nums))))
      k)
    -1))