(define (memLeak memory1 memory2)
  (let loop ([time 1] [m1 memory1] [m2 memory2])
    (cond
      [(or (< m1 time) (< m2 time))
       (list time m1 m2)]
      [(>= m1 m2)
       (loop (add1 time) (- m1 time) m2)]
      [else
       (loop (add1 time) m1 (- m2 time))])))