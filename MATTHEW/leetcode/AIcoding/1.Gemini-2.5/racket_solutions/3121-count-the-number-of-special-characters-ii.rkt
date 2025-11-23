#lang racket

(define (count-special-characters s)
  (define n (string-length s))

  (define max-lower-idx (make-vector 26 -1))
  (define min-upper-idx (make-vector 26 n))

  (for ([i (in-range n)])
    (define ch (string-ref s i))
    (cond
      [(char-lower-case? ch)
       (define idx (- (char->integer ch) (char->integer #\a)))
       (vector-set! max-lower-idx idx i)]
      [(char-upper-case? ch)
       (define idx (- (char->integer ch) (char->integer #\A)))
       (vector-set! min-upper-idx idx (min (vector-ref min-upper-idx idx) i))])))

  (define special-count 0)
  (for ([i (in-range 26)])
    (define lower-max (vector-ref max-lower-idx i))
    (define upper-min (vector-ref min-upper-idx i))
    (when (and (not (= lower-max -1))
               (not (= upper-min n))
               (< lower-max upper-min))
      (set! special-count (+ special-count 1))))

  special-count)