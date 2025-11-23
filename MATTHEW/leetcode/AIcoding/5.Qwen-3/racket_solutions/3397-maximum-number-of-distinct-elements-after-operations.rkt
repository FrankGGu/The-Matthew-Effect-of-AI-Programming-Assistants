#lang racket

(define (max-distinct-nums nums)
  (define freq (make-hash))
  (for-each (lambda (n) (hash-set! freq n (+ 1 (hash-ref freq n 0)))) nums)
  (define cnt (make-hash))
  (for ([(k v) (in-hash freq)])
    (hash-set! cnt v (+ 1 (hash-ref cnt v 0))))
  (define res 0)
  (for ([i (in-range 1 (add1 (hash-max-key cnt)))])
    (when (hash-has-key? cnt i)
      (set! res (+ res (min (hash-ref cnt i) (- (expt 2 i) 1))))))
  res)