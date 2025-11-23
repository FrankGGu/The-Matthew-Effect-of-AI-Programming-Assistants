#lang racket

(define (find-k-diff-pairs nums k)
  (define freq (make-hash))
  (for ([n nums])
    (hash-set! freq n (+ (hash-ref freq n 0) 1)))
  (define result 0)
  (if (= k 0)
      (for/sum ([v (in-hash-values freq)])
        (if (>= v 2) 1 0))
      (for/sum ([n (in-hash-keys freq)])
        (if (hash-has-key? freq (+ n k)) 1 0))))
  result)