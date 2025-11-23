(define (smallest-equal-value nums)
  (let loop ([i 0])
    (cond
      [(>= i (vector-length nums)) -1]
      [(= i (modulo (vector-ref nums i) 10)) i]
      [else (loop (+ i 1))])))