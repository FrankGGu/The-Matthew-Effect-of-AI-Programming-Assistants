#lang racket

(define/contract (highest-grade grid)
  (-> (listof (listof exact-integer?)) exact-integer?)
  (define (max-diff row)
    (let loop ([i 0] [min-val (car row)] [max-diff 0])
      (if (= i (length row))
          max-diff
          (loop (+ i 1) (min min-val (list-ref row i)) (max max-diff (- (list-ref row i) min-val))))))
  (apply max (map max-diff grid)))