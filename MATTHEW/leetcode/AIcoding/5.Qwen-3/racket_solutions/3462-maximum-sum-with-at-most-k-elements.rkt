#lang racket

(define/contract (max-sum-heap nums k)
  (-> (listof exact-integer?) exact-integer? exact-integer?)
  (define heap (list->heap nums))
  (define (helper res count)
    (if (or (zero? count) (heap-empty? heap))
        res
        (helper (+ res (heap-pop! heap)) (sub1 count))))
  (helper 0 k))