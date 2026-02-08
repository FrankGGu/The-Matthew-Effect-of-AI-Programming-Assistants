#lang racket

(define/contract (min-days bloom-day m k)
  (-> (listof exact-integer?) exact-integer? exact-integer? exact-integer?)
  (define n (length bloom-day))
  (if (< n (* m k))
      -1
      (let ()
        (define (can-make-bouquets days)
          (let loop ([i 0] [bouquets 0] [flowers 0])
            (cond
              [(>= bouquets m) #t]
              [(>= i n) (>= bouquets m)]
              [else (if (<= (list-ref bloom-day i) days)
                        (if (= (add1 flowers) k)
                            (loop (add1 i) (add1 bouquets) 0)
                            (loop (add1 i) bouquets (add1 flowers)))
                        (loop (add1 i) bouquets 0)]))))
        (let binary-search ([left 1] [right (apply max bloom-day)])
          (if (= left right)
              left
              (let ([mid (quotient (+ left right) 2)])
                (if (can-make-bouquets mid)
                    (binary-search left mid)
                    (binary-search (add1 mid) right)))))))))