#lang racket
(require racket/set)

(define (minimum-operations nums)
  (define positive-nums (filter (lambda (x) (> x 0)) nums))
  (define distinct-positive-nums (list->set positive-nums))
  (set-count distinct-positive-nums))