#lang racket/base

(require racket/hash)
(require racket/control)

(define (repeated-n-element nums)
  (let/ec return-repeated
    (let ([seen-elements (make-hash-set)])
      (for-each (lambda (x)
                  (when (hash-set-contains? seen-elements x)
                    (return-repeated x))
                  (hash-set-add! seen-elements x))
                nums))))