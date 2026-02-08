(define (is-one-bit-character bits)
  (let loop ([i 0] [n (length bits)])
    (cond
      [(>= i n) #f]
      [(= i (- n 1)) #t]
      [(= (list-ref bits i) 1) (loop (+ i 2) n)]
      [else (loop (+ i 1) n)])))