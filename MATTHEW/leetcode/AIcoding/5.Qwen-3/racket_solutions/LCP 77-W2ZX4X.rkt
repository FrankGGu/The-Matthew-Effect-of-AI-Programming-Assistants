(define (num-rabbits ans)
  (define (helper counts)
    (cond [(null? counts) 0]
          [else
           (let ([n (car counts)])
             (+ (if (= (remainder n 2) 0)
                    (/ n 2)
                    (quotient n 2))
                (helper (cdr counts))))]))
  (helper ans))