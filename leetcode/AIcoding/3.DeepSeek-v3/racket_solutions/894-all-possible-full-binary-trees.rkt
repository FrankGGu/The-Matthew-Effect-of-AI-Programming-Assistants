#lang racket

(define (all-possible-fbt n)
  (define memo (make-hash))
  (hash-set! memo 1 (list (make-node 0 null null)))
  (define (helper n)
    (if (hash-has-key? memo n)
        (hash-ref memo n)
        (let ([res '()])
          (for ([i (in-range 1 n 2)])
            (let* ([left (helper i)]
                   [right (helper (- n i 1))])
              (for* ([l left]
                     [r right])
                (set! res (cons (make-node 0 l r) res)))))
          (hash-set! memo n res)
          res)))
  (if (odd? n) (helper n) '()))

(define (make-node val left right)
  (list val left right))