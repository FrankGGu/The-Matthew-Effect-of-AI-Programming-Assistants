(define (self-dividing? n)
  (cond
    [(zero? n) #f]
    [else
     (let loop ([num n])
       (cond
         [(zero? num) #t]
         [else
          (let ([digit (modulo num 10)])
            (cond
              [(zero? digit) #f]
              [(not (zero? (modulo n digit))) #f]
              [else (loop (quotient num 10))]))]))]))

(define (self-dividing-numbers left right)
  (filter self-dividing? (range left (+ right 1))))