#lang racket

(define (minimize-string-length s)
  (set-count (list->set (string->list s))))