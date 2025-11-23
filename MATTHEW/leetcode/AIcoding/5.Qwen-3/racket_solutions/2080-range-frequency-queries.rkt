#lang racket

(define (make-freq-map lst)
  (for/fold ([m (hash)]) ([x lst])
    (hash-update m x add1 0)))

(define (range-freq-queries queries)
  (let* ([lst (map first queries)]
         [freq-map (make-freq-map lst)]
         [result '()])
    (for ([q queries])
      (let ([x (second q)]
            [l (third q)]
            [r (fourth q)])
        (set! result (cons (hash-ref freq-map x 0) result))))
    (reverse result)))