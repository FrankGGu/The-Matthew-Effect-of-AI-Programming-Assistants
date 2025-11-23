(define (is-ugly? n)
  (cond
    [(<= n 0) #f]
    [(= n 1) #t]
    [else
     (let loop ([n n])
       (cond
         [(= (modulo n 2) 0) (loop (/ n 2))]
         [(= (modulo n 3) 0) (loop (/ n 3))]
         [(= (modulo n 5) 0) (loop (/ n 5))]
         [(= n 1) #t]
         [else #f]))]))

(define (nth-ugly-number n)
  (let loop ([i 1] [count 0])
    (cond
      [(= count n) i]
      [(is-ugly? i) (loop (+ i 1) (+ count 1))]
      [else (loop (+ i 1) count)])))