(define (calculate s)
  (let loop ([x 1] [y 0] [chars (string->list s)])
    (cond
      [(empty? chars) (+ x y)]
      [(equal? (car chars) #\A) (loop (+ x y) y (cdr chars))]
      [else (loop x (+ x y) (cdr chars))])))