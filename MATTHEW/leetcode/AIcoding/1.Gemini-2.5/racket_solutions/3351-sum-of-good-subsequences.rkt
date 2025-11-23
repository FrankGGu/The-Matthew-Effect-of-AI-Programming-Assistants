(define (sum-of-good-subsequences nums)
  (define MOD 1000000007)
  (define n (length nums))
  (define sorted-nums (list-sort < nums))

  (define (pow base exp)
    (let loop ([res 1] [b base] [e exp])
      (cond
        ((zero? e) res)
        ((odd? e) (loop (modulo (* res b) MOD) (modulo (* b b) MOD) (quotient e 2)))
        (else (loop res (modulo (* b b) MOD) (quotient e 2))))))

  (foldl (lambda (i acc)
           (define num (list-ref sorted-nums i))
           (define term-max (modulo (* num (pow 2 i)) MOD))
           (define term-min (modulo (* num (pow 2 (- n 1 i))) MOD))
           (modulo (+ acc term-max (- 0 term-min)) MOD))
         0
         (range n)))