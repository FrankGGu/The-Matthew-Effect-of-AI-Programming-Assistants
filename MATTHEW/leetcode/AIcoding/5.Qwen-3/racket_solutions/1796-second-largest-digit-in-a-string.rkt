#lang racket

(define (second-largest-digit s)
  (define digits
    (filter (lambda (c) (char-numeric? c))
            (string->list s)))
  (define sorted-digits
    (sort (map (lambda (c) (- (char->integer c) (char->integer #\0))) digits) >))
  (if (< (length sorted-digits) 2)
      -1
      (let ([unique-digits (remove-duplicates sorted-digits)])
        (if (< (length unique-digits) 2)
            -1
            (list-ref unique-digits 1)))))