#lang racket

(define (parse-time time-str)
  (define parts (string-split time-str ":"))
  (define hours (string->number (car parts)))
  (define minutes (string->number (cadr parts)))
  (values hours minutes))

(define (convert-time current correct)
  (define-values (ch cm) (parse-time current))
  (define-values (cch ccm) (parse-time correct))

  (define current-total-minutes (+ (* ch 60) cm))
  (define correct-total-minutes (+ (* cch 60) ccm))

  (define diff (- correct-total-minutes current-total-minutes))

  (define operations 0)

  (set! operations (+ operations (quotient diff 60)))
  (set! diff (remainder diff 60))

  (set! operations (+ operations (quotient diff 15)))
  (set! diff (remainder diff 15))

  (set! operations (+ operations (quotient diff 5)))
  (set! diff (remainder diff 5))

  (set! operations (+ operations diff))

  operations)