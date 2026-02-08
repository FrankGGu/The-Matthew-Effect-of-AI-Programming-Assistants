(define (has-alternating-bits n)
  (define (check n)
    (if (= n 0)
        #t
        (let ([bit (modulo n 2)])
          (if (= bit (modulo (sub1 n) 2))
              #f
              (check (quotient n 2))))))
  (check n))