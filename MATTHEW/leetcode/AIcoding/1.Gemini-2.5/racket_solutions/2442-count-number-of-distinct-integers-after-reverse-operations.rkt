#lang racket

(require racket/set)

(define (reverse-integer n)
  (string->number (string-reverse (number->string n))))

(define (count-distinct-integers nums)
  (define reversed-nums (map reverse-integer nums))
  (define combined-nums (append nums reversed-nums))
  (define distinct-set (list->set combined-nums))
  (set-count distinct-set))