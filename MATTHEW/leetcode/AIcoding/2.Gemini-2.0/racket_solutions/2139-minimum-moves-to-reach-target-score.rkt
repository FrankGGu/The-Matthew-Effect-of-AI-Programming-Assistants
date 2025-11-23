(define (min-moves target max-doubles)
  (let loop ([target target] [max-doubles max-doubles] [moves 0])
    (cond
      [(= target 1) moves]
      [(<= max-doubles 0) (+ moves (- target 1))]
      [(even? target) (loop (/ target 2) (- max-doubles 1) (+ moves 1))]
      [else (loop (- target 1) max-doubles (+ moves 1))])))