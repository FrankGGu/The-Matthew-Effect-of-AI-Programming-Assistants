(define (is-ugly n)
  (cond
    [(<= n 0) #f]
    [(= n 1) #t]
    [else
     (let loop ([current-n n])
       (cond
         [(= current-n 1) #t]
         [(zero? (remainder current-n 2)) (loop (/ current-n 2))]
         [(zero? (remainder current-n 3)) (loop (/ current-n 3))]
         [(zero? (remainder current-n 5)) (loop (/ current-n 5))]
         [else #f]))]))