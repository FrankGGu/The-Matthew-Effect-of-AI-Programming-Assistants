(define (coin-change coins amount)
  (if (= amount 0)
      0
      (let* ([dp (make-vector (add1 amount) (add1 amount))]
             [_ (vector-set! dp 0 0)])

        (for ([i (in-range 1 (add1 amount))])
          (for ([coin coins])
            (when (>= i coin)
              (let ([prev-dp-val (vector-ref dp (- i coin))])
                (unless (= prev-dp-val (add1 amount))
                  (vector-set! dp i (min (vector-ref dp i) (add1 prev-dp-val))))))))

        (let ([result (vector-ref dp amount)])
          (if (= result (add1 amount))
              -1
              result)))))