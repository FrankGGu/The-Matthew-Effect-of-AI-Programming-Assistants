#lang racket

(define (minimum-operations nums)
  (define n (length nums))
  (define dp (make-vector n #f))
  (define (solve i)
    (if (= i n) 0
        (let ([res (if (vector-ref dp i) (vector-ref dp i) #f)])
          (if res res
              (let ([current (list-ref nums i)])
                (let loop ([j (+ i 1)] [min-ops +inf.0])
                  (if (> j n) 
                      (begin
                        (vector-set! dp i min-ops)
                        min-ops)
                      (let ([new-xor (bitwise-xor current (list-ref nums j))])
                        (if (= new-xor 0)
                            (let ([ops (add1 (solve j))])
                              (loop (+ j 1) (min min-ops ops)))
                            (loop (+ j 1) min-ops))))))))))
  (solve 0))