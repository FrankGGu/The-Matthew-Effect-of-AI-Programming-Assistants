(define (finalArray nums k)
  (define (helper nums k)
    (if (zero? k)
        nums
        (helper (map (lambda (x) (if (even? x) (/ x 2) x)) nums) (sub1 k))))
  (helper nums k))