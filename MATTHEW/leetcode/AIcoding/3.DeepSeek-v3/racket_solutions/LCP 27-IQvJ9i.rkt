(define (mirror-reflection p q)
  (let loop ([k 1])
    (cond
      [(zero? (modulo (* k q) p)) 
       (if (even? (quotient (* k q) p))
           (if (even? k) 1 0)
           2)]
      [else (loop (add1 k))])))