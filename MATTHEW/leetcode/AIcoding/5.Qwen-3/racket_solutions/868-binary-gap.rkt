#lang racket

(define/contract (binary-gap n)
  (-> exact-integer? exact-integer?)
  (let loop ([n n] [last 0] [gap 0])
    (if (= n 0)
        gap
        (let ([bit (remainder n 2)])
          (if (= bit 1)
              (loop (quotient n 2) (add1 (logcount n)) (max gap (- (logcount n) last)))
              (loop (quotient n 2) last gap))))))