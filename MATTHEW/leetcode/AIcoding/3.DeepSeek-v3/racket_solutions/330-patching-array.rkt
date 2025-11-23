(define (min-patches nums n)
  (let loop ([i 0] [miss 1] [added 0])
    (cond
      [(> miss n) added]
      [(and (< i (vector-length nums)) (<= (vector-ref nums i) miss))
       (loop (+ i 1) (+ miss (vector-ref nums i)) added)]
      [else
       (loop i (+ miss miss) (+ added 1))])))