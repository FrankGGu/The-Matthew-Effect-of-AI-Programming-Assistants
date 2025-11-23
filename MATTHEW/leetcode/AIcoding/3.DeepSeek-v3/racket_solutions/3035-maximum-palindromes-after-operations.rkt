#lang racket

(define (max-palindromes-after-operations words)
  (define freq (make-hash))
  (for ([word words])
    (for ([c (string->list word)])
      (hash-update! freq c add1 0)))
  (define odd-count 0)
  (for ([(k v) (in-hash freq)])
    (when (odd? v)
      (set! odd-count (add1 odd-count))))
  (if (<= odd-count (length words))
      (length words)
      (- (length words) 1)))