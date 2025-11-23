(define (minimum-numbers num k)
  (cond
    [(zero? num) 0]
    [(> k num) -1]
    [else
     (let loop ([i 1])
       (cond
         [(>= (* i k) num)
          (if (equal? (modulo (* i k) 10) (modulo num 10))
              i
              (if (equal? k 0)
                  -1
                  (loop (+ i 1))))]
         [(equal? (* i k) num) i]
         [(> i 10) -1]
         [else (loop (+ i 1))]))]))