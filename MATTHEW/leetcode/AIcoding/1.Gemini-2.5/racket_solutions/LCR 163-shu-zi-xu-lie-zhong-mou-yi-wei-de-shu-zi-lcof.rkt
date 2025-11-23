#lang racket

(define (findKthNumber n k)
  (let loop ((current 1) (k (- k 1)))
    (if (= k 0)
        current
        (let* ((count-val (let count-subtree ((first current) (last (+ current 1)) (c 0))
                            (if (> first n)
                                c
                                (count-subtree (* first 10) (* last 10)
                                               (+ c (- (+ (min n (- last 1)) 1) first)))))))
          (if (>= k count-val)
              (loop (+ current 1) (- k count-val))
              (loop (* current 10) (- k 1)))))))