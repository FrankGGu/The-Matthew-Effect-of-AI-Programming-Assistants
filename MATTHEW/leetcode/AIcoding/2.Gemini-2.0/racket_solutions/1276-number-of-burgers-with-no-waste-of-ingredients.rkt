(define (solve tomato cheese)
  (let loop ([x 0])
    (cond [(>= x (+ cheese 1)) '()]
          [(= (+ (* 4 x) (* 2 (- cheese x))) tomato) (list x (- cheese x))]
          [else (loop (+ x 1))])))

(define (number-of-burgers tomato-slices cheese-slices)
  (solve tomato-slices cheese-slices))