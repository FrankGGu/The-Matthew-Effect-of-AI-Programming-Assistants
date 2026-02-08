#lang racket

(define (solve)
  (let* ([N (read)]
         [K (read)])
    (let loop ([i 0]
               [min-u +inf.0]
               [max-u -inf.0]
               [min-v +inf.0]
               [max-v -inf.0])
      (if (= i N)
          (let ([max-u-diff (+ (- max-u min-u) K)]
                [max-v-diff (+ (- max-v min-v) K)])
            (max max-u-diff max-v-diff))
          (let* ([x (read)]
                 [y (read)]
                 [u (+ x y)]
                 [v (- x y)])
            (loop (+ i 1)
                  (min min-u u)
                  (max max-u u)
                  (min min-v v)
                  (max max-v v)))))))

(solve)