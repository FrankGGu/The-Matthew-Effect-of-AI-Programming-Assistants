#lang racket

(define/contract (minimum-element nums)
  (-> (listof exact-integer?) exact-integer?)
  (define (digit-sum n)
    (if (= n 0)
        0
        (+ (remainder n 10) (digit-sum (quotient n 10)))))
  (define (replace n)
    (let ((s (digit-sum n)))
      (if (> s 9)
          (replace s)
          s)))
  (apply min (map replace nums)))