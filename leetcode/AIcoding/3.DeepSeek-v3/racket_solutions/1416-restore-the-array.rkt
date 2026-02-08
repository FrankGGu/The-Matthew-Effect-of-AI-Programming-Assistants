#lang racket

(define (number-of-arrays s k)
  (define n (string-length s))
  (define dp (make-vector (+ n 1) 0))
  (vector-set! dp n 1)
  (define mod 1000000007)

  (for ([i (in-range (- n 1) -1 -1)])
    (when (char=? (string-ref s i) #\0)
      (vector-set! dp i 0)
      (continue))

    (define count 0)
    (define num 0)
    (for ([j (in-range i n)])
      (set! num (+ (* num 10) (- (char->integer (string-ref s j)) 48)))
      (when (> num k)
        (break))
      (set! count (modulo (+ count (vector-ref dp (+ j 1))) mod)))
    (vector-set! dp i count))

  (vector-ref dp 0))