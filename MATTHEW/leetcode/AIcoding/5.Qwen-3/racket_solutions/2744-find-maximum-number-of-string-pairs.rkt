#lang racket

(define/contract (maximum-pair-count nums)
  (-> (listof string) exact-integer?)
  (define freq (make-hash))
  (for-each (lambda (s)
              (hash-set! freq s (+ 1 (hash-ref freq s 0))))
            nums)
  (define count 0)
  (for ([k (in-hash-keys freq)])
    (when (and (not (equal? k ""))
               (>= (hash-ref freq k) 2))
      (set! count (+ count (quotient (hash-ref freq k) 2)))))
  count)