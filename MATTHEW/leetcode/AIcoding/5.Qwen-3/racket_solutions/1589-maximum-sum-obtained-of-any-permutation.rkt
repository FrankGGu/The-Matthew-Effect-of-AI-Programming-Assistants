#lang racket

(define (range a b)
  (if (> a b)
      '()
      (cons a (range (+ a 1) b))))

(define (max-sum-obtained nums)
  (define n (length nums))
  (define freq (make-vector 101 0))
  (for-each (lambda (x) (vector-set! freq x (+ (vector-ref freq x) 1))) nums)
  (define res 0)
  (define i 1)
  (define j 1)
  (for ([k (in-range 1 101)])
    (when (and (>= (vector-ref freq k) 1) (< j n))
      (set! res (+ res (* k j)))
      (set! j (+ j 1))))
  res)