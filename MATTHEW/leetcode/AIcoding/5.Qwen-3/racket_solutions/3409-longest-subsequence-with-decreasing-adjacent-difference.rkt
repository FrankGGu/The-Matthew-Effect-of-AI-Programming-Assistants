#lang racket

(define (longest-decreasing-subsequence nums)
  (define n (length nums))
  (define dp (make-vector n 1))
  (define (max-val i)
    (for/fold ([max 0]) ([j (in-range i)])
      (if (and (< (vector-ref nums j) (vector-ref nums i))
               (> (- (vector-ref nums j) (vector-ref nums i)) 0))
          (max max (vector-ref dp j))
          max)))
  (for ([i (in-range n)])
    (vector-set! dp i (+ 1 (max-val i))))
  (apply max (vector->list dp)))

(define (main)
  (define input (read))
  (printf "~a\n" (longest-decreasing-subsequence input)))

(main)