(define (find-winner arr k)
  (define n (vector-length arr))
  (if (>= k n) (apply max (vector->list arr))
      (let loop ([winner (vector-ref arr 0)] [wins 0] [i 1])
        (if (= wins k) winner
            (let ([current (vector-ref arr i)])
              (if (> winner current)
                  (loop winner (+ wins 1) (+ i 1))
                  (loop current 1 (+ i 1))))))))