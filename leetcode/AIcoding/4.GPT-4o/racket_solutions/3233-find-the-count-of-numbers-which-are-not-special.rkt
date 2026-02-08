(define (countNonSpecialNumbers n)
  (define (isSpecial x)
    (let loop ((i 1) (s 0))
      (cond
        ((> i (sqrt x)) #f)
        ((= (modulo x i) 0) 
         (if (= i (* i))
             (loop (+ i 1) s)
             (loop (+ i 1) (+ s 2)))
        )
        (else (loop (+ i 1) s)))))

  (define (countSpecial up-to)
    (for/sum ([i (in-range 1 (add1 up-to))] #:when (isSpecial i))
      1))

  (- n (countSpecial n)))

(countNonSpecialNumbers n)