(define (sum-subseq-widths nums)
  (define MOD 1000000007)
  (define n (length nums))
  (define sorted-nums (sort nums <))

  (define powers (make-vector n))
  (vector-set! powers 0 1)
  (for ([i (in-range 1 n)])
    (vector-set! powers i (modulo (* 2 (vector-ref powers (- i 1))) MOD)))

  (define total-sum 0)
  (for ([i (in-range n)]
        [num sorted-nums])
    (define term-max (vector-ref powers i))
    (define term-min (vector-ref powers (- n 1 i)))

    (define diff (modulo (- term-max term-min) MOD))

    (define contribution (modulo (* num diff) MOD))

    (set! total-sum (modulo (+ total-sum contribution) MOD)))

  (modulo (+ total-sum MOD) MOD))