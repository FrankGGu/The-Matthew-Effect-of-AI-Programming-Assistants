(define (smallest-equal nums)
  (let loop ([i 0])
    (cond
      [(>= i (length nums)) -1]
      [(= (modulo i 10) (list-ref nums i)) i]
      [else (loop (+ i 1))])))