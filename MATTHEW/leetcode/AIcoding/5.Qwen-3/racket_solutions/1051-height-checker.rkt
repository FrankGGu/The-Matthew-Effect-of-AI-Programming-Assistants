#lang racket

(define (height-checker heights)
  (define sorted (sort heights <))
  (define (count-mismatches i)
    (if (= i (length heights))
        0
        (+ (if (= (list-ref heights i) (list-ref sorted i)) 0 1)
           (count-mismatches (+ i 1)))))
  (count-mismatches 0))