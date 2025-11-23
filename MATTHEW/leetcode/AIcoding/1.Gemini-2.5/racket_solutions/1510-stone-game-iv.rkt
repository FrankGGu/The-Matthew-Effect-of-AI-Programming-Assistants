(define (winner-square-game n)
  (define dp (make-vector (+ n 1) #f))

  (for ([i (in-range 1 (+ n 1))])
    (for ([j (in-range 1 (add1 (floor (sqrt i))))])
      (when (not (vector-ref dp (- i (* j j))))
        (vector-set! dp i #t)
        (break))))

  (vector-ref dp n))