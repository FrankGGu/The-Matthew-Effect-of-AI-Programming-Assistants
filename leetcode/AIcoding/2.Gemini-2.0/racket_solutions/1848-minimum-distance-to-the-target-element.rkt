(define (min-distance nums target start)
  (let loop ([i 0] [min-dist +inf.0])
    (cond
      [(>= i (length nums)) min-dist]
      [(= (list-ref nums i) target) (loop (+ i 1) (min min-dist (abs (- i start))))]
      [else (loop (+ i 1) min-dist)])))