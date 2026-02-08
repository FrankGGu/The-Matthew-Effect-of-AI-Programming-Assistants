#lang racket

(define/contract (num-of-minutes n headID manager informTime)
  (-> exact-integer? exact-integer? (listof exact-integer?) (listof exact-integer?) exact-integer?)
  (define adj (make-vector n '()))
  (for ([i (in-range n)]
        [m manager])
    (unless (= m -1)
      (vector-set! adj m (cons i (vector-ref adj m)))))
  (define (dfs u)
    (define max-time 0)
    (for ([v (vector-ref adj u)])
      (set! max-time (max max-time (dfs v))))
    (+ max-time (list-ref informTime u)))
  (dfs headID))