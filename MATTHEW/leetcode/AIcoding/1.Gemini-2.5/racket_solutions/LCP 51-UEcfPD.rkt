#lang racket

(require srfi/1)

(define (max-satisfaction satisfaction)
  (let* ([sorted-satisfaction (list-sort < satisfaction)]
         [n (length sorted-satisfaction)])
    (let loop ([i (- n 1)]
               [current-sum-of-satisfactions 0]
               [total-like-time 0]
               [max-like-time 0])
      (if (< i 0)
          max-like-time
          (let* ([s (list-ref sorted-satisfaction i)]
                 [next-sum (+ current-sum-of-satisfactions s)])
            (if (> next-sum 0)
                (loop (- i 1)
                      next-sum
                      (+ total-like-time next-sum)
                      (max max-like-time (+ total-like-time next-sum)))
                max-like-time))))))