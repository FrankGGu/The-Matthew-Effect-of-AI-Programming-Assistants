(define (min-operations nums)
  (let loop ([i 0] [current-gcd (car nums)] [min-ops +inf.0] [ops 0])
    (cond
      [(= current-gcd 1) (min min-ops (+ ops (sub1 (length nums))))]
      [(>= i (length nums)) min-ops]
      [else
       (let ([new-gcd (gcd current-gcd (list-ref nums i))])
         (loop (add1 i) new-gcd min-ops (add1 ops)))])))