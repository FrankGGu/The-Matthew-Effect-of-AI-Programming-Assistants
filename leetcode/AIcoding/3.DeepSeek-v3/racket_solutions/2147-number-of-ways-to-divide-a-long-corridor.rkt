#lang racket

(define (number-of-ways corridor)
  (define MOD 1000000007)
  (define n (string-length corridor))
  (define seats 0)
  (define plants 0)
  (define result 1)
  (for ([i (in-range n)])
    (define c (string-ref corridor i))
    (cond
      [(char=? c #\S)
       (set! seats (add1 seats))
       (when (and (> plants 0) (even? seats))
         (set! result (modulo (* result (add1 plants)) MOD))
         (set! plants 0))]
      [(char=? c #\P)
       (when (odd? seats)
         (set! plants (add1 plants)))]))
  (if (or (zero? seats) (odd? seats)) 0 result))