(define (max-nice-divisors n)
  (define mod 1000000007)
  (cond
    [(<= n 3) n]
    [(= n 4) 4]
    [(= n 5) 6]
    [else
     (let loop ([n n] [res 1])
       (if (<= n 4)
           (modulo (* res n) mod)
           (loop (- n 3) (modulo (* res 3) mod))))]))