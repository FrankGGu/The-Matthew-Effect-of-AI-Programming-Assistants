(define (lemonade-change bills)
  (let loop ([bills bills] [five 0] [ten 0])
    (cond
      [(empty? bills) #t]
      [(eqv? (first bills) 5) (loop (rest bills) (+ five 1) ten)]
      [(eqv? (first bills) 10)
       (if (> five 0)
           (loop (rest bills) (- five 1) (+ ten 1))
           #f)]
      [else
       (cond
         [(and (> ten 0) (> five 0))
          (loop (rest bills) (- five 1) (- ten 1))]
         [(>= five 3)
          (loop (rest bills) (- five 3) ten)]
         [else
          #f])])))