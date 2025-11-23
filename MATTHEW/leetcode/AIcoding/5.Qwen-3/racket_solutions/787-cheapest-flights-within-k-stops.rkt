#lang racket

(define (find-cheapest-price n flights src dst k)
  (define graph (make-hash))
  (for ([f flights])
    (let ([u (car f)] [v (cadr f)] [w (caddr f)])
      (hash-update! graph u (λ (lst) (cons (cons v w) lst)) '())))
  (define pq (priority-queue #:priority (λ (a b) (< (car a) (car b)))))
  (priority-queue-add! pq (cons 0 (cons src -1)))
  (define dist (make-vector n +inf.0))
  (vector-set! dist src 0)
  (let loop ()
    (when (not (priority-queue-empty? pq))
      (let* ([curr (priority-queue-remove! pq)]
             [cost (car curr)]
             [node (caadr curr)]
             [stops (cdadr curr)])
        (when (and (<= stops k) (< cost (vector-ref dist node)))
          (vector-set! dist node cost)
          (for ([neighbor (hash-ref graph node '())])
            (let ([next-node (car neighbor)]
                  [next-cost (+ cost (cdr neighbor))])
              (priority-queue-add! pq (cons next-cost (cons next-node (+ stops 1)))))))
        (loop)))
  (if (infinite? (vector-ref dist dst)) -1 (vector-ref dist dst)))