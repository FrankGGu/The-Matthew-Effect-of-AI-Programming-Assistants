#lang racket

(define (check-if-the-sentence-is-pangram sentence)
  (= (set-count (string->set sentence)) 26))