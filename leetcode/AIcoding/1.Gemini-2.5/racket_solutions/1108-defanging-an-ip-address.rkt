#lang racket

(define (defang-ip-addr address)
  (string-replace address "." "[.]"))