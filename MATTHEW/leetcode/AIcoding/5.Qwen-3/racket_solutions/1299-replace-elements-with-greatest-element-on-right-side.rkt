#lang racket

(define/contract (replace-elements nums)
  (-> (listof exact-integer?) (listof exact-integer?))
  (let ([n (length nums)])
    (if (= n 0)
        '()
        (let ([result (make-vector n -1)])
          (let loop ([i (- n 2)] [max-right (vector-ref nums (- n 1))])
            (when (>= i 0)
              (vector-set! result i max-right)
              (loop (- i 1) (max max-right (vector-ref nums i))))
          (vector->list result)))))