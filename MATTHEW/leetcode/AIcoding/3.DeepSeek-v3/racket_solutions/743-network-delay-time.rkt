#lang racket

(require data/heap)

(define/contract (network-delay-time times n k)
  (-> (listof (listof exact-integer?)) exact-integer? exact-integer? exact-integer?)
  (define graph (make-hash))
  (for ([edge times])
    (match-define (list u v w) edge)
    (hash-update! graph u (lambda (neighbors) (cons (cons v w) neighbors)) '()))

  (define dist (make-vector (add1 n) +inf.0))
  (vector-set! dist k 0)

  (define heap (make-heap (lambda (a b) (< (car a) (car b)))))
  (heap-add! heap (cons 0 k))

  (let loop ()
    (unless (heap-empty? heap)
      (match-define (cons d u) (heap-min heap))
      (heap-remove-min! heap)
      (when (<= d (vector-ref dist u))
        (for ([neighbor (hash-ref graph u '())])
          (match-define (cons v w) neighbor)
          (when (< (+ d w) (vector-ref dist v))
            (vector-set! dist v (+ d w))
            (heap-add! heap (cons (vector-ref dist v) v)))))
      (loop)))

  (define max-dist (apply max (vector->list (vector-copy dist 1 (add1 n)))))
  (if (= max-dist +inf.0) -1 max-dist))