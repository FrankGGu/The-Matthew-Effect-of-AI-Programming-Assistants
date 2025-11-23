(define (profitable-schemes n minProfit group profit)
  (define MOD 1000000007)

  (define dp (make-vector (+ minProfit 1) (void)))
  (for ([p (in-range (+ minProfit 1))])
    (vector-set! dp p (make-vector (+ n 1) 0)))

  (vector-set! (vector-ref dp 0) 0 1)

  (for ([k (in-range (length group))])
    (define current-group (list-ref group k))
    (define current-profit (list-ref profit k))

    (for ([g (in-range n (- current-group 1) -1)])
      (for ([p (in-range minProfit -1 -1)])
        (define prev-ways (vector-ref (vector-ref dp p) (- g current-group)))

        (when (> prev-ways 0)
          (define new-profit-idx (min minProfit (+ p current-profit)))

          (define current-ways-at-new-state (vector-ref (vector-ref dp new-profit-idx) g))

          (vector-set! (vector-ref dp new-profit-idx) g
                       (modulo (+ current-ways-at-new-state prev-ways) MOD))))))

  (define total-schemes 0)
  (for ([g (in-range (+ n 1))])
    (set! total-schemes (modulo (+ total-schemes (vector-ref (vector-ref dp minProfit) g)) MOD)))

  total-schemes)