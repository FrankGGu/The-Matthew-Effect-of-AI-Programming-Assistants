#lang racket

(require racket/list)

(define (get-first-three-rows rows)
  (take rows 3))