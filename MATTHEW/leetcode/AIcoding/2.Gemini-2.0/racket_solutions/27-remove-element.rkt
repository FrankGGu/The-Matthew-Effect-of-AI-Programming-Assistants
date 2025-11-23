(define (remove-element nums val)
  (let loop ([i 0] [k 0])
    (cond
      [(>= i (vector-length nums)) k]
      [(= (vector-ref nums i) val) (loop (+ i 1) k)]
      [else (begin
              (vector-set! nums k (vector-ref nums i))
              (loop (+ i 1) (+ k 1)))])))