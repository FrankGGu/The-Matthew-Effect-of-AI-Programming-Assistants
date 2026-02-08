#lang racket

(define (bus-rapid-transit target inc dec jump-costs)
  (define costs (make-hash))
  (hash-set! costs 0 0)

  (define (helper x)
    (cond
      [(hash-ref costs x #f) (hash-ref costs x)]
      [else
       (let ([min-cost (+ (* x inc) (helper 0))])
         (for ([j (in-list jump-costs)]
               [i (in-naturals 1)])
           (let-values ([(q r) (quotient/remainder x i)])
             (set! min-cost (min min-cost
                                 (+ (helper q) jump-costs (if (zero? r) 0 inc))
                                 (+ (helper (add1 q)) jump-costs (if (zero? r) 0 (+ (* (- i r) dec) inc))))))
         (hash-set! costs x min-cost)
         min-cost)]))

  (helper target))