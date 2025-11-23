#lang racket

(define (maximum-difference-between-even-and-odd-frequency-ii nums)
  (let-values (((even-count odd-count)
                (foldl (lambda (num counts)
                         (let-values (((e o) counts))
                           (if (even? num)
                               (values (+ e 1) o)
                               (values e (+ o 1)))))
                       (values 0 0)
                       nums)))
    (abs (- even-count odd-count))))