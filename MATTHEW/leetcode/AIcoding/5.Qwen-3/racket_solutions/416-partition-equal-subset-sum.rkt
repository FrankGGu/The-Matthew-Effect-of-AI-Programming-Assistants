#lang racket

(define (can-partition nums)
  (define sum (apply + nums))
  (cond [(odd? sum) #f]
        [else
         (define target (/ sum 2))
         (define dp (make-vector (+ target 1) #f))
         (vector-set! dp 0 #t)
         (for ([num nums])
           (for ([i (in-range target (- num 1) -1)])
             (when (vector-ref dp i)
               (vector-set! dp (+ i num) #t))))
         (vector-ref dp target)]))