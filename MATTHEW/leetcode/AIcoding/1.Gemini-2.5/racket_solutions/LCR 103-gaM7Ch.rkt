(define (coin-change coins amount)
  (if (= amount 0)
      0
      (let* ((max-val (+ amount 1))
             (dp (make-vector (+ amount 1) max-val)))
        (vector-set! dp 0 0)

        (for ([i (in-range 1 (+ amount 1))])
          (for ([coin coins])
            (when (>= (- i coin) 0)
              (let ((prev-dp-val (vector-ref dp (- i coin))))
                (when (< prev-dp-val max-val)
                  (vector-set! dp i (min (vector-ref dp i) (+ prev-dp-val 1))))))))

        (let ((result (vector-ref dp amount)))
          (if (= result max-val)
              -1
              result)))))