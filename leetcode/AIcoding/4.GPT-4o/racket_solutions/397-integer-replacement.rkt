(define (integer-replacement n)
  (define (helper x count)
    (cond ((= x 1) count)
          ((even? x) (helper (/ x 2) (+ count 1)))
          (else (min (helper (sub1 x) (+ count 1)) (helper (add1 x) (+ count 1))))))
  (helper n 0))

(define (integerReplacement n)
  (integer-replacement n))