(define (makesquare matchsticks)
  (let* ([total (apply + matchsticks)]
         [side (quotient total 4)])
    (if (or (null? matchsticks) (not (zero? (remainder total 4))))
        #f
        (let ([sides (make-vector 4 0)]
              [matchsticks (sort matchsticks >)])
          (define (backtrack index)
            (if (= index (length matchsticks))
                #t
                (let loop ([i 0])
                  (if (= i 4)
                      #f
                      (begin
                        (vector-set! sides i (+ (vector-ref sides i) (list-ref matchsticks index)))
                        (if (and (<= (vector-ref sides i) side) (backtrack (+ index 1)))
                        (vector-set! sides i (- (vector-ref sides i) (list-ref matchsticks index)))
                        (if (backtrack (+ index 1)) #t (loop (+ i 1))))))))
          (backtrack 0)))))