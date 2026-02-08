#lang racket

(define (interchangeable-rectangles rectangles)
  (define ratio-counts (make-hash))

  (for-each (lambda (rect)
              (define w (car rect))
              (define h (cadr rect))

              (define common-divisor (gcd w h))

              (define simplified-w (/ w common-divisor))
              (define simplified-h (/ h common-divisor))

              (define ratio (list simplified-w simplified-h))

              (hash-update! ratio-counts ratio (lambda (count) (+ count 1)) 0))
            rectangles)

  (define total-pairs 0)

  (hash-for-each (lambda (ratio count)
                   (set! total-pairs (+ total-pairs (quotient (* count (- count 1)) 2))))
                 ratio-counts)

  total-pairs)