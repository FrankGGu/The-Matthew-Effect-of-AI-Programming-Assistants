(define (range-freq arr left right value)
  (let loop ([i left] [count 0])
    (cond
      [(> i right) count]
      [(= (list-ref arr i) value) (loop (+ i 1) (+ count 1))]
      [else (loop (+ i 1) count)])))