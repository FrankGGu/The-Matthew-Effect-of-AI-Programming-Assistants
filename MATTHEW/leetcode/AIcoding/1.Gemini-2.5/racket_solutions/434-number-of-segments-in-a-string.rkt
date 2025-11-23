#lang racket

(require racket/string)

(define (count-segments s)
  (length (string-split s)))