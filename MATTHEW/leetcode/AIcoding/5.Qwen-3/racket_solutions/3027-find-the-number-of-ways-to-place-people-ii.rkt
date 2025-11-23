#lang racket

(define (number-of-ways nums)
  (define n (length nums))
  (define dp (make-vector n 0))
  (define freq (make-hash))
  (for-each (lambda (x) (hash-update! freq x add1)) nums)
  (for ([i (in-range n)])
    (when (>= (vector-ref dp i) 2)
      (vector-set! dp i 0))
    (when (hash-has-key? freq (add1 (list-ref nums i)))
      (vector-set! dp i (+ (vector-ref dp i) (hash-ref freq (add1 (list-ref nums i))) 1))))
  (apply + (vector->list dp)))