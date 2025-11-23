#lang racket

(define (top-k-frequent nums k)
  (define freq (make-hash))
  (for ([n nums])
    (hash-set! freq n (+ 1 (hash-ref freq n 0))))
  (define sorted (sort (hash->list freq) (lambda (a b) (> (cdr a) (cdr b)))))
  (take (map car sorted) k))