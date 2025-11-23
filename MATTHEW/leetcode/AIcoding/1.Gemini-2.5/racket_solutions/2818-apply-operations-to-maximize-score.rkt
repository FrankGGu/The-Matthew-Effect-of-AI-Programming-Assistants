#lang racket

(require data/heap)

(define (maximize-score nums k)
  (let* ([pq (make-heap >)]
         [current-score 0])
    (for-each (lambda (n) (heap-add! pq n)) nums)
    (for ([_ (in-range k)])
      (let* ([max-val (heap-min pq)]
             [new-val (floor (/ max-val 3))])
        (set! current-score (+ current-score max-val))
        (heap-remove-min! pq)
        (heap-add! pq new-val)))
    current-score))