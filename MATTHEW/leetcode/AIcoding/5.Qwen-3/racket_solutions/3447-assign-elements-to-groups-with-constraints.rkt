#lang racket

(define (max-groups nums k)
  (define (count-possible x)
    (let loop ([i 0] [cnt 0])
      (if (>= i (vector-length nums)) cnt
          (let ([val (vector-ref nums i)])
            (if (<= (- val x) k)
                (loop (+ i 1) (+ cnt 1))
                (loop (+ i 1) cnt))))))
  (let ([sorted (vector-sort nums <)])
    (let loop ([low 0] [high (vector-length nums)])
      (if (> low high) 0
          (let ([mid (quotient (+ low high) 2)])
            (if (>= (count-possible mid) (quotient (vector-length nums) 2))
                (loop (+ mid 1) high)
                (loop low (- mid 1))))))) )