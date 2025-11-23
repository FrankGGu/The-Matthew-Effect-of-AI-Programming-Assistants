#lang racket

(define (sum-distance nums)
  (define n (length nums))
  (define pos (make-hash))
  (for ([i (in-range n)]
        [num nums])
    (hash-update! pos num (λ (lst) (cons i lst)) '()))
  (define res 0)
  (for ([i (in-range n)]
        [num nums])
    (define lst (hash-ref pos num))
    (define idx (index-of lst i))
    (define left (take lst idx))
    (define right (drop lst (add1 idx)))
    (set! res (+ res (* (- i (car left)) (length left))))
    (set! res (+ res (* (- (car right) i) (length right)))))
  res)