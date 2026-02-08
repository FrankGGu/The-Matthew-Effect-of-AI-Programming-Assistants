#lang racket

(require racket/set)

(define (minimum-operations nums)
  (define unique-positive-nums (make-set))
  (for-each (lambda (num)
              (when (> num 0)
                (set-add! unique-positive-nums num)))
            nums)
  (set-count unique-positive-nums))