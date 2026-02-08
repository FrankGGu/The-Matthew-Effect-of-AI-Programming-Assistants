(define (clumsy n)
  (let loop ([i n] [op 0] [acc 0] [last 0])
    (cond
      [(<= i 0) (+ acc last)]
      [(= op 0) (loop (- i 1) 1 acc (* last i))]
      [(= op 1) (loop (- i 1) 2 acc (quotient last i))]
      [(= op 2) (loop (- i 1) 3 acc (+ last i))]
      [else (loop (- i 1) 0 (+ acc last) (- i))])))

(define (main)
  (displayln (clumsy 10)))