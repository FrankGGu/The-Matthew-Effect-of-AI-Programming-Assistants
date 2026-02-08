#lang racket

(require data/deque)

(define (max-score-after-k-operations nums k)
  (define n (vector-length nums))

  (define dp (make-vector n 0))

  (define dq (make-deque)) ; Stores (score . index) pairs

  (vector-set! dp 0 (vector-ref nums 0))
  (deque-add-back! dq (cons (vector-ref nums 0) 0))

  (for ([i (in-range 1 n)])
    (let loop-front ()
      (when (and (not (deque-empty? dq))
                 (< (cdr (deque-front dq)) (- i k)))
        (deque-remove-front! dq)
        (loop-front)))

    (define current-max-prev-score (car (deque-front dq)))
    (define current-score (+ (vector-ref nums i) current-max-prev-score))
    (vector-set! dp i current-score)

    (let loop-back ()
      (when (and (not (deque-empty? dq))
                 (<= (car (deque-back dq)) current-score))
        (deque-remove-back! dq)
        (loop-back)))

    (deque-add-back! dq (cons current-score i)))

  (vector-ref dp (- n 1)))