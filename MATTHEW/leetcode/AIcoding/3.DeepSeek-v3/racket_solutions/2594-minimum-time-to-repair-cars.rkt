#lang racket

(define/contract (repair-cars ranks cars)
  (-> (listof exact-integer?) exact-integer? exact-integer?)
  (define (possible? time)
    (let loop ([r ranks] [total 0])
      (if (null? r)
          (>= total cars)
          (let ([cnt (inexact->exact (floor (sqrt (/ time (car r)))))])
            (loop (cdr r) (+ total cnt))))))

  (let binary-search ([left 1] [right (let ([max-r (apply max ranks)])
                                        (* max-r cars cars))])
    (if (= left right)
        left
        (let ([mid (quotient (+ left right) 2)])
          (if (possible? mid)
              (binary-search left mid)
              (binary-search (+ mid 1) right))))))