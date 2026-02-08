#lang racket

(define (min-operations-to-make-equal arr)
  (let ([counts (make-hash)])
    (for ([num arr])
      (hash-update! counts num add1 0))
    (let ([max-count 0])
      (hash-for-each counts (lambda (k v) (set! max-count (max max-count v))))
      (- (length arr) max-count))))

(define (main)
  (let* ([input (read-line)]
         [arr (map string->number (string-split input))])
    (displayln (min-operations-to-make-equal arr))))

(main)