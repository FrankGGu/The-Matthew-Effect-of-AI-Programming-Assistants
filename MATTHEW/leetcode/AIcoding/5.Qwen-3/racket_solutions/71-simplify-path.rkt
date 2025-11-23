#lang racket

(define (simplify-path path)
  (define (split str sep)
    (string-split str sep))

  (define (join lst sep)
    (string-join lst sep))

  (define parts (split path #\/))
  (define stack '())

  (for ([part parts])
    (cond [(equal? part "") #f]
          [(equal? part ".") #f]
          [(equal? part "..") (set! stack (reverse (cdr (reverse stack))))]
          [else (set! stack (append stack (list part)))]))

  (join stack "/"))