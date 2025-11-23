(define (check-pw-of-three n)
  (define (helper x)
    (cond
      [(= x 0) #t]
      [(> x 0) (or (helper (- x 1)) (helper (- x 3)))]
      [else #f]))
  (helper n))

(check-pw-of-three n)