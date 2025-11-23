#lang racket

(define (four-divisors n)
  (define (count-divisors x)
    (let loop ([i 2] [count 0])
      (cond [(> i (sqrt x)) count]
            [(= (modulo x i) 0)
             (if (= i (/ x i))
                 (loop (+ i 1) (+ count 1))
                 (loop (+ i 1) (+ count 2)))]
            [else (loop (+ i 1) count)])))
  (define (is-four? x)
    (= (count-divisors x) 4))
  (filter is-four? (range 1 (+ n 1))))