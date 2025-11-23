#lang racket

(define (largest-perimeter nums)
  (define sorted (sort nums >))
  (define (check i)
    (if (>= i 2)
        (and (<= (list-ref sorted i) (+ (list-ref sorted (- i 1)) (list-ref sorted (- i 2))))
             (check (- i 1)))
        #t))
  (define (loop i res)
    (if (>= i (length sorted))
        res
        (let ([current (+ (list-ref sorted i) (list-ref sorted (- i 1)) (list-ref sorted (- i 2)))])
          (if (check i)
              (loop (+ i 1) current)
              (loop (+ i 1) res)))))
  (loop 2 0))