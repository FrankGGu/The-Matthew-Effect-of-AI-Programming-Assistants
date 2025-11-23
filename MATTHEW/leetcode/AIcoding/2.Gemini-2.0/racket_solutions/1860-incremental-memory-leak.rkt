(define (mem-leak memory1 memory2)
  (let loop ([cycle 1] [m1 memory1] [m2 memory2])
    (cond
      [(and (>= m1 cycle) (>= m2 cycle))
       (loop (+ cycle 1) (- m1 cycle) (- m2 cycle))]
      [(>= m1 cycle)
       (loop (+ cycle 1) (- m1 cycle) m2)]
      [(>= m2 cycle)
       (loop (+ cycle 1) m1 (- m2 cycle))]
      [else
       (list cycle m1 m2)])))