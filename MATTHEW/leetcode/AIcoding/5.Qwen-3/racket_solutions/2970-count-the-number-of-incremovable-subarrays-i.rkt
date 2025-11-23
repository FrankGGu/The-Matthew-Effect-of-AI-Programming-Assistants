#lang racket

(define (num-subarray-incremovable nums)
  (define n (length nums))
  (define res 0)
  (define (is-increasing? l r)
    (and (<= l r)
         (for/and ([i (in-range l (- r 1))])
           (< (list-ref nums i) (list-ref nums (+ i 1))))))
  (for ([i (in-range n)])
    (for ([j (in-range i n)])
      (when (is-increasing? i j)
        (set! res (+ res 1)))))
  res)