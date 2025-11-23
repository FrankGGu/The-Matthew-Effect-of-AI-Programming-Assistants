#lang racket

(define (remove-methods-from-project project-methods)
  (filter (lambda (method-name)
            (not (string-contains? method-name "remove")))
          project-methods))