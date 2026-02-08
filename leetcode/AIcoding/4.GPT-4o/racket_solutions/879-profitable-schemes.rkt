(define (profitableSchemes n minProfit group profit)
  (define mod 1000000007)
  (define m (length profit))

  (define dp (make-vector (+ n 1) (make-vector (+ minProfit 1) 0)))
  (vector-set! dp 0 0 1)

  (for ([i (in-range m)])
    (define g (vector-ref group i))
    (define p (vector-ref profit i))

    (for ([j (in-range n g -1)])
      (for ([k (in-range (+ minProfit 1) (max 0 (- minProfit p)) -1)])
        (vector-set! dp (+ j g) k
          (mod (+ (vector-ref dp j k) (vector-ref dp j (+ k p))) mod)))))

  (define result 0)
  (for ([j (in-range n +1)])
    (for ([k (in-range minProfit +1)])
      (set! result (mod (+ result (vector-ref dp j k)) mod))))

  result)

(define (profitableSchemes-main)
  (let ([n 5]
        [minProfit 3]
        [group (vector 2 2)
        [profit (vector 2 3)]])
    (profitableSchemes n minProfit group profit)))

(profitableSchemes-main)