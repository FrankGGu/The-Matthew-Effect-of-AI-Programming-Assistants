(define (is-ugly n)
  (if (<= n 0)
      #f
      (let loop ([n n])
        (cond
          [(= n 1) #t]
          [(zero? (modulo n 2)) (loop (/ n 2))]
          [(zero? (modulo n 3)) (loop (/ n 3))]
          [(zero? (modulo n 5)) (loop (/ n 5))]
          [else #f]))))