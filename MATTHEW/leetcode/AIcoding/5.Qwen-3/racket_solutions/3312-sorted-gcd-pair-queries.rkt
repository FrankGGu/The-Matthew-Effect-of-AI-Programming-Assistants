#lang racket

(define (gcd a b)
  (if (= b 0)
      a
      (gcd b (remainder a b))))

(define (sorted-gcd-pair-queries nums queries)
  (define n (length nums))
  (define nums-sorted (sort nums <))
  (define freq (make-hash))
  (for ([num nums-sorted])
    (hash-set! freq num (+ (hash-ref freq num 0) 1)))
  (define max-num (apply max nums))
  (define dp (make-vector (add1 max-num) 0))
  (for ([i (in-range 1 (add1 max-num))])
    (for ([j (in-range i (add1 max-num) i)])
      (vector-set! dp j (+ (vector-ref dp j) (hash-ref freq j 0)))))
  (define result '())
  (for ([q queries])
    (define target q)
    (define count (vector-ref dp target))
    (set! result (cons count result)))
  (reverse result))