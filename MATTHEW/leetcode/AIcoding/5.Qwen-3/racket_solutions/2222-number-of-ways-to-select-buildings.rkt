#lang racket

(define (number-of-ways s)
  (define len (string-length s))
  (define cnt (make-vector 3 0))
  (for ([c s])
    (cond
      [(char=? c #\0) (vector-set! cnt 0 (+ (vector-ref cnt 0) 1))]
      [(char=? c #\1) (vector-set! cnt 1 (+ (vector-ref cnt 1) 1))]))
  (let loop ([i 0] [pre0 0] [pre1 0] [res 0])
    (if (= i len)
        res
        (let ([c (string-ref s i)])
          (cond
            [(char=? c #\0)
             (loop (+ i 1) (+ pre0 1) pre1 (+ res pre1))]
            [(char=? c #\1)
             (loop (+ i 1) pre0 (+ pre1 1) (+ res pre0))])))))