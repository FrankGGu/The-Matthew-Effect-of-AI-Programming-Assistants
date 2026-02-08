#lang racket/base

(require racket/list)

(define (single-number-iii nums)
  (define xor-sum (foldl bitwise-xor 0 nums))

  (define distinguishing-bit (bitwise-and xor-sum (- xor-sum)))

  (define num1 0)
  (define num2 0)

  (for-each
   (lambda (num)
     (if (not (zero? (bitwise-and num distinguishing-bit)))
         (set! num1 (bitwise-xor num1 num))
         (set! num2 (bitwise-xor num2 num))))
   nums)

  (list num1 num2))