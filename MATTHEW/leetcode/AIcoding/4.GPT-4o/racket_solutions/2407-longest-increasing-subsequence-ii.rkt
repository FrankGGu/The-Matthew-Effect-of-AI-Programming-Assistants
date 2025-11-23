#lang racket

(define (lengthOfLIS nums k)
  (define n (length nums))
  (define dp (make-vector n 1))
  (for ([i (in-range n)])
    (for ([j (in-range i)])
      (when (and (< (vector-ref nums j) (vector-ref nums i))
                 (<= (- (vector-ref nums i) (vector-ref nums j)) k))
        (vector-set! dp i (max (vector-ref dp i) (+ 1 (vector-ref dp j))))))
    (for ([j (in-range i)])
      (when (and (> (vector-ref nums i) (vector-ref nums j))
                 (< (vector-ref nums i) (+ (vector-ref nums j) k)))
        (vector-set! dp i (max (vector-ref dp i) (+ 1 (vector-ref dp j))))))
  (apply max (vector->list dp)))

(define (lengthOfLIS nums k)
  (lengthOfLIS nums k))