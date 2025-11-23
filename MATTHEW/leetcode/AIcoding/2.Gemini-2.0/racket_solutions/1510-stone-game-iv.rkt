(define (stone-game-iv n)
  (define dp (make-vector (+ n 1) #f))
  (vector-set! dp 0 #f)
  (for ([i (in-range 1 (+ n 1))])
    (let loop ([j 1])
      (cond
        [(> (* j j) i) (vector-set! dp i #f)]
        [(= (* j j) i) (vector-set! dp i #t)]
        [(not (vector-ref dp (- i (* j j)))) (vector-set! dp i #t)]
        [else (loop (+ j 1))])))
  (vector-ref dp n))