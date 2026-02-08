(define (isUgly n)
  (if (<= n 0) 
      #f
      (let loop ((n n))
        (cond ((= n 1) #t)
              ((modulo n 2) (loop (quotient n 2)))
              ((modulo n 3) (loop (quotient n 3)))
              ((modulo n 5) (loop (quotient n 5)))
              (else #f))))))