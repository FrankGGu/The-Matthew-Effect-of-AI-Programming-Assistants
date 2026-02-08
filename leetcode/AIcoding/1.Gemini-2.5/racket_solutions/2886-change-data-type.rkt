#lang racket

(define (change-data-type strs)
  (map string->number strs))