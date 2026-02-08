(define/contract (self-dividing-numbers left right)
  (-> exact-integer? exact-integer? (listof exact-integer?))
  (define (self-dividing? n)
    (let loop ((num n))
      (cond
        [(zero? num) #t]
        [(zero? (remainder n (remainder num 10)))
         (loop (quotient num 10))]
        [else #f])))
  (filter self-dividing? (range left (+ right 1))))