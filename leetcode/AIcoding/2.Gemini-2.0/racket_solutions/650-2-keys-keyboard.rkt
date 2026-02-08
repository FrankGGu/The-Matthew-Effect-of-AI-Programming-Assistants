(define (minSteps n)
  (define (helper n acc)
    (cond
      [(= n 1) acc]
      [else
       (let loop ([i 2])
         (cond
           [(> i (sqrt n)) (+ acc n -1)]
           [(= (remainder n i) 0) (helper (/ n i) (+ acc i))]
           [else (loop (+ i 1))]))]))
  (helper n 0))