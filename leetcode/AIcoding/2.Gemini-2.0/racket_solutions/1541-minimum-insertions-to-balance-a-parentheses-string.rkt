(define (min-insertions s)
  (let loop ([s (string->list s)] [open 0] [insertions 0])
    (cond
      [(empty? s)
       (+ insertions (* 2 open))]
      [(= (car s) #\()
       (loop (cdr s) (+ open 1) insertions)]
      [else
       (if (> open 0)
           (loop (cdr s) (- open 1) (+ insertions (if (and (not (empty? s)) (= (car (cdr s)) #\))) 0 1)))
           (loop (cdr s) 0 (+ insertions 1 (if (and (not (empty? s)) (= (car (cdr s)) #\))) 0 1))))])))