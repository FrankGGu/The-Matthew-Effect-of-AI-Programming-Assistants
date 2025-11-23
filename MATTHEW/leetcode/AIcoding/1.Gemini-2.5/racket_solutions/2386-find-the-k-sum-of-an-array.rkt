#lang racket

(require data/heap)

(define (k-sum nums k)
  (define abs-nums (sort (map abs nums) <))

  (define max-sum (foldl + 0 abs-nums))

  (define pq (make-heap (lambda (a b) (< (car a) (car b)))))
  (heap-add! pq (list 0 0))

  (define target-delta-sum 0)

  (let loop ((count 0))
    (when (< count k)
      (define current-item (heap-min pq))
      (heap-remove-min! pq)

      (define current-delta (car current-item))
      (define idx (cadr current-item))

      (set! target-delta-sum current-delta)

      (when (< idx (length abs-nums))
        (heap-add! pq (list (+ current-delta (list-ref abs-nums idx)) (+ idx 1)))

        (when (> idx 0)
          (heap-add! pq (list (+ current-delta (list-ref abs-nums idx) (- (list-ref abs-nums (- idx 1)))) (+ idx 1)))))
      (loop (+ count 1))))

  (- max-sum (* 2 target-delta-sum)))