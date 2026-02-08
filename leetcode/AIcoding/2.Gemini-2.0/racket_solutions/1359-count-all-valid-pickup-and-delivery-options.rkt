(define (count-orders n)
  (define MOD 1000000007)
  (let loop ((pairs n) (result 1))
    (if (= pairs 0)
        result
        (loop (- pairs 1)
              (modulo (* result (* pairs (+ (* 2 pairs) -1))) MOD)))))