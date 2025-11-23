(define (num-ways n)
  (define (mod x) (remainder x 1000000007))
  (if (= n 1) 6
      (let loop ([n n] [a 6] [b 6])
        (if (= n 1) a
            (loop (- n 1) b (mod (+ (* 2 b) (* 2 a)) ))))))