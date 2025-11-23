#lang racket

(define/contract (largest-local-values matrix)
  (-> (listof (listof exact-integer?)) (listof (listof exact-integer?)))
  (define n (length matrix))
  (define m (length (car matrix)))
  (define result '())
  (for ([i (in-range (- n 1))])
    (define row '())
    (for ([j (in-range (- m 1))])
      (define max-val
        (for/fold ([max-val -inf.0])
          ([x (in-range i (+ i 2))]
           [y (in-range j (+ j 2))])
          (max max-val (list-ref (list-ref matrix x) y))))
      (set! row (cons max-val row)))
    (set! result (cons (reverse row) result)))
  (reverse result))