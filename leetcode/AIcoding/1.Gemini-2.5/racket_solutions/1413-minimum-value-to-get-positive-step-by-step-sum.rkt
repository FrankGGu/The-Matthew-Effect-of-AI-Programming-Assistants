#lang racket

(define (min-start-value nums)
  (let-values (((min-prefix-sum current-prefix-sum))
               (for/fold ((min-prefix-sum 0)
                          (current-prefix-sum 0))
                         ((num nums))
                 (let ((new-current-prefix-sum (+ current-prefix-sum num)))
                   (values (min min-prefix-sum new-current-prefix-sum)
                           new-current-prefix-sum)))))
    (- 1 min-prefix-sum)))