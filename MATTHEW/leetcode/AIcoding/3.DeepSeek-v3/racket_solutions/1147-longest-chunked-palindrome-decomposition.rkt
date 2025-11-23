#lang racket

(define (longest-decomposition text)
  (define n (string-length text))
  (define (helper left right len res)
    (cond
      [(> left right) res]
      [(= left right) (add1 res)]
      [else
       (define found #f)
       (define new-len 0)
       (for ([k (in-range 1 (add1 (quotient (- right left -1) 2))])
         (when (and (not found)
                   (string=? (substring text left (+ left k))
                             (substring text (- right k -1) (+ right 1))))
           (set! found #t)
           (set! new-len k)))
       (if found
           (helper (+ left new-len) (- right new-len) new-len (+ res 2))
           (add1 res))]))
  (helper 0 (sub1 n) 0 0))