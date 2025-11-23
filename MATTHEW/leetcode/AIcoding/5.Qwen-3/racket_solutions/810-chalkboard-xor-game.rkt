#lang racket

(define (xor-game nums)
  (define (xor-sum lst)
    (foldl bitwise-xor 0 lst))
  (if (= (modulo (length nums) 2) 1)
      #t
      (if (= (xor-sum nums) 0)
          #t
          #f)))