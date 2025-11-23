#lang racket

(define (max-sliding-window nums k)
  (define n (length nums))
  (define q (make-queue))
  (define result '())
  (for ([i (in-range n)])
    (when (and (> i 0) (= (queue-length q) k)) (queue-remove! q))
    (while (and (not (queue-empty? q)) (> (queue-last q) (list-ref nums i)))
      (queue-remove! q))
    (queue-add! q i)
    (when (>= i (sub1 k))
      (set! result (append result (list (list-ref nums (queue-first q)))))))
  result)