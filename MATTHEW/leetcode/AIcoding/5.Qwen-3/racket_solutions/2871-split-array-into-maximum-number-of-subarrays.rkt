#lang racket

(define (split-array-into-maximum-number-of-subarrays nums)
  (define (helper i count seen)
    (cond [(= i (length nums)) count]
          [else
           (let ([current (list-ref nums i)])
             (if (set-member? seen current)
                 (helper (add1 i) count seen)
                 (helper (add1 i) (add1 count) (set-add seen current))))]))
  (helper 0 0 (set)))

(define (main)
  (let ([input (read)])
    (displayln (split-array-into-maximum-number-of-subarrays input))))

(main)