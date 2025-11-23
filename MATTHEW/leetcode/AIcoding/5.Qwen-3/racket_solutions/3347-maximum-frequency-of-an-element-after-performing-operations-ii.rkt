#lang racket

(define (max-frequency nums k)
  (define (count-ops left right)
    (- (vector-ref nums right) (vector-ref nums left)))

  (define (helper left right freq max-freq)
    (if (> right (vector-length nums))
        max-freq
        (let ((current-ops (count-ops left right)))
          (if (<= current-ops k)
              (helper left (+ right 1) (+ freq 1) (max max-freq (+ freq 1)))
              (helper (+ left 1) right (- freq 1) max-freq)))))

  (sort nums <)
  (helper 0 0 0 0))