(define (num-squares n)
  (define dp (make-vector (+ n 1)))
  (vector-set! dp 0 0)

  (for ([i (in-range 1 (+ n 1))])
    (define min-val n)
    (for ([j (in-range 1 (+ (floor (sqrt i)) 1))])
      (define square (* j j))
      (define prev-dp-val (vector-ref dp (- i square)))
      (set! min-val (min min-val (+ prev-dp-val 1))))
    (vector-set! dp i min-val))

  (vector-ref dp n))