#lang racket

(define (number-of-different-integers s)
  (define (parse-number str)
    (if (string=? str "")
        0
        (string->number str)))
  (define (remove-leading-zeros str)
    (if (and (> (string-length str) 1) (char=? #\0 (string-ref str 0)))
        (remove-leading-zeros (substring str 1))
        str))
  (define nums
    (map (lambda (x) (remove-leading-zeros x)) (regexp-split #px"\\D+" s)))
  (define unique-nums
    (set-remove (apply set (map parse-number nums)) 0))
  (set-count unique-nums))