#lang racket

(define (product-recommendation-pairs nums)
  (define freq (make-hash))
  (for-each (lambda (n) (hash-set! freq n (+ 1 (hash-ref freq n 0)))) nums)
  (define result '())
  (for ([k (in-hash-keys freq)])
    (when (and (> k 0) (hash-has-key? freq (* k k)))
      (set! result (append result (list (list k k)))))
    (when (and (> k 0) (hash-has-key? freq (/ k 2)) (= (modulo k 2) 0))
      (set! result (append result (list (list (/ k 2) k))))))
  (sort (remove-duplicates result #:key (lambda (x) (sort x <))) (lambda (a b) (< (car a) (cadr a)))))