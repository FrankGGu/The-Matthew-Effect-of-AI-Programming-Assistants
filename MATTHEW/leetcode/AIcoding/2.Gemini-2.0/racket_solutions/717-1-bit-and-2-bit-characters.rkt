(define (is-one-bit-character bits)
  (let loop ([i 0])
    (cond
      [(>= i (length bits)) #t]
      [(= (list-ref bits i) 1) (loop (+ i 2))]
      [else (loop (+ i 1))])))