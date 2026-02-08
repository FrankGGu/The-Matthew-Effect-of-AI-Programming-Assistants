#lang racket

(define (monotone-increasing-digits N)
  (define s (number->string N))
  (define len (string-length s))
  (define digits (make-vector len))

  (for ([i (in-range len)])
    (vector-set! digits i (- (char->integer (string-ref s i)) (char->integer #\0))))

  (define flag-idx len)

  (for ([i (in-range (- len 1) 0 -1)])
    (when (> (vector-ref digits (- i 1)) (vector-ref digits i))
      (vector-set! digits (- i 1) (- (vector-ref digits (- i 1)) 1))
      (set! flag-idx i)))

  (for ([j (in-range flag-idx len)])
    (vector-set! digits j 9))

  (define result 0)
  (for ([d (in-vector digits)])
    (set! result (+ (* result 10) d)))
  result)