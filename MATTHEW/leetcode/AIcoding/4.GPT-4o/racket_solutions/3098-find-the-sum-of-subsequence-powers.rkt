(define (sum-of-subseq-powers nums)
  (define mod 1000000007)
  (define n (length nums))
  (define total-sum 0)
  (define power-sum 0)

  (for ([i (in-range n)])
    (set! total-sum (+ total-sum (expt 2 i)))
    (set! power-sum (+ power-sum (modulo (* (expt 2 (- n 1)) (list-ref nums i)) mod))))

  (modulo (* total-sum power-sum) mod))

(define (sumOfSubseqPowers nums)
  (sum-of-subseq-powers nums))