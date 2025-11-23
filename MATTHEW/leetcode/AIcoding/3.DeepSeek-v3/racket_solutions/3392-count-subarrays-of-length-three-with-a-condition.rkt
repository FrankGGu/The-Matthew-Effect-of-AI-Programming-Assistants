(define (count-good-triplets arr a b c)
  (let loop ([i 0] [count 0])
    (if (>= i (- (length arr) 2))
        count
        (let* ([x (list-ref arr i)]
               [y (list-ref arr (+ i 1))]
               [z (list-ref arr (+ i 2))])
          (if (and (<= (abs (- x y)) a)
                    (<= (abs (- y z)) b)
                    (<= (abs (- x z)) c))
              (loop (+ i 1) (+ count 1))
              (loop (+ i 1) count))))))