#lang racket

(define (can-jump nums)
  (define (jump-helper index max-reach)
    (if (>= index (length nums))
        #t
        (if (<= index max-reach)
            (jump-helper (+ index 1) (max max-reach (+ index (list-ref nums index))))
            #f)))
  (jump-helper 0 0))

(define (canJump nums)
  (can-jump nums))