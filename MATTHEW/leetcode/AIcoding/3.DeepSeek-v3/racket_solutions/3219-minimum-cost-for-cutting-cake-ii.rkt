#lang racket

(define (minimum-cost cake-h cake-v)
  (define (helper h v)
    (let ([h-sorted (sort h >)]
          [v-sorted (sort v >)])
      (let loop ([h h-sorted] [v v-sorted] [h-pieces 1] [v-pieces 1] [cost 0])
        (cond
          [(and (null? h) (null? v)) cost]
          [(or (null? h) (and (not (null? v)) (> (car v) (if (null? h) -inf.0 (car h)))))
           (loop h (cdr v) h-pieces (add1 v-pieces) (+ cost (* (car v) h-pieces)))]
          [else
           (loop (cdr h) v (add1 h-pieces) v-pieces (+ cost (* (car h) v-pieces))]))))
  (helper cake-h cake-v))