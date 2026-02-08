#lang racket

(define (is-punishment-number? n target)
  (define s (number->string n))
  (define len (string-length s))
  (define (dfs pos sum path)
    (cond
      [(= pos len) (= sum target)]
      [else
       (for/or ([i (in-range pos len)])
         (define num (string->number (substring s pos (+ i 1))))
         (dfs (+ i 1) (+ sum num) (cons num path)))]))
  (dfs 0 0 '()))

(define (punishment-number n)
  (for/sum ([i (in-range 1 (+ n 1))])
    (define square (* i i))
    (if (is-punishment-number? square i)
        square
        0)))