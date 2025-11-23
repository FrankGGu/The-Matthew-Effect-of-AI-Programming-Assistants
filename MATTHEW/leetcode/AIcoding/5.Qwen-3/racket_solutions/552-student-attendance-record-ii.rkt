(define (check-record n)
  (define mod 1000000007)
  (define (dp i a l)
    (cond [(= i n) 1]
          [else
           (let ([res (dp (+ i 1) a 0)])
             (if (< a 1)
                 (modulo (+ res (dp (+ i 1) (+ a 1) 0)) mod)
                 res))]))
  (dp 0 0 0))