#lang racket
(require racket/set)

(define (contains-duplicate nums)
  (< (set-count (list->set nums)) (length nums)))