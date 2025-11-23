#lang racket

(require racket/string)

(define (reverse-words s)
  (let* ([trimmed-s (string-trim s)]
         [words (string-split trimmed-s " ")]
         [non-empty-words (filter (lambda (w) (> (string-length w) 0)) words)]
         [reversed-words (reverse non-empty-words)])
    (string-join reversed-words " ")))