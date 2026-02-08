(define (count-arrangement n)
  (define (backtrack pos used)
    (if (> pos n)
        1
        (let loop ([num 1] [count 0])
          (if (> num n)
              count
              (if (and (not (vector-ref used num))
                       (or (= (remainder num pos) 0)
                           (= (remainder pos num) 0)))
                  (begin
                    (vector-set! used num #t)
                    (loop (+ num 1) (+ count (backtrack (+ pos 1) used)))
                    (vector-set! used num #f)
                    (loop (+ num 1) count))
                  (loop (+ num 1) count))))))
  (backtrack 1 (make-vector (+ n 1) #f)))