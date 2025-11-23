#lang racket

(define (non-decreasing? s)
  (let loop ([i 0])
    (cond [(>= i (- (string-length s) 1)) #t]
          [(char<=? (string-ref s i) (string-ref s (+ i 1))) (loop (+ i 1))]
          [else #f])))

(define (count-numbers-with-non-decreasing-digits n)
  (define (helper i)
    (if (> i n)
        0
        (+ (if (non-decreasing? (number->string i)) 1 0) (helper (+ i 1)))))
  (helper 1))

(define input (string->number (car (file->lines "stdin"))))
(displayln (count-numbers-with-non-decreasing-digits input))