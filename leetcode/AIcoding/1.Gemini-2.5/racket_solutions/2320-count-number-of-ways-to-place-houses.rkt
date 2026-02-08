(define (count-house-placements n)
  (define MOD 1000000007)

  (cond
    ((= n 0) 1)
    (else
     (let loop ((k 1) (prev 1) (curr 2))
       (if (= k n)
           (modulo (* curr curr) MOD)
           (loop (+ k 1) curr (modulo (+ prev curr) MOD)))))))