#lang racket

(require math/number-theory)

(define/contract (maximum-sum nums)
  (-> (listof exact-integer?) exact-integer?)
  (define n (length nums))
  (define max-sum 0)
  (define (square-free? k)
    (let loop ([i 2] [k k])
      (cond
        [(= k 1) #t]
        [(zero? (modulo k (* i i))) #f]
        [(> (* i i) k) #t]
        [else (loop (add1 i) k)])))
  (for ([k (in-range 1 (add1 n))])
    (when (square-free? k)
      (let loop ([i k] [current-sum 0])
        (cond
          [(> i n) (set! max-sum (max max-sum current-sum))]
          [else (loop (+ i k) (+ current-sum (list-ref nums (sub1 i))))]))))
  max-sum)