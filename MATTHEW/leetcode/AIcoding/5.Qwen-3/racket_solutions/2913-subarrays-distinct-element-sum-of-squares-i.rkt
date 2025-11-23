#lang racket

(define (sum-of-squares nums)
  (define (helper i seen)
    (if (= i (length nums))
        0
        (let* ([num (list-ref nums i)]
               [new-seen (if (member num seen) seen (cons num seen))]
               [current (expt (length new-seen) 2)]
               [rest (helper (+ i 1) new-seen)])
          (+ current rest))))
  (helper 0 '()))