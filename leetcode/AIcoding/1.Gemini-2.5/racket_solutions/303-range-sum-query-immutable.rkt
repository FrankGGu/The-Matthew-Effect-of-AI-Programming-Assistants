#lang racket

(struct NumArray (prefix-sums))

(define (NumArray-init nums)
  (let* ([n (vector-length nums)]
         [prefix-sums (make-vector (+ n 1) 0)])
    (for ([i (in-range n)])
      (vector-set! prefix-sums (+ i 1) (+ (vector-ref prefix-sums i) (vector-ref nums i))))
    (NumArray prefix-sums)))

(define (NumArray-sumRange self left right)
  (let ([prefix-sums (NumArray-prefix-sums self)])
    (- (vector-ref prefix-sums (+ right 1))
       (vector-ref prefix-sums left))))