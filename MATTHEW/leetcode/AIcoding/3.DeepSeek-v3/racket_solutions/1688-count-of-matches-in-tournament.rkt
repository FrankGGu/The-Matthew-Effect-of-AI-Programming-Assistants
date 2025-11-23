(define (number-of-matches n)
  (let loop ([n n] [matches 0])
    (cond
      [(= n 1) matches]
      [(even? n) (loop (/ n 2) (+ matches (/ n 2)))]
      [else (loop (/ (sub1 n) 2) (+ matches (/ (sub1 n) 2)))])))