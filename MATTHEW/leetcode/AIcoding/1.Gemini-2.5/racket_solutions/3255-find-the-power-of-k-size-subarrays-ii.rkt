#lang racket
(require data/deque)

(define (find-power-of-k-size-subarrays-ii nums k)
  (define n (length nums))
  (define nums-vec (list->vector nums))
  (define result-acc '())
  (define dq (make-deque))

  (for ([i (in-range n)])
    (when (and (not (deque-empty? dq))
               (= (deque-front dq) (- i k)))
      (deque-pop-front! dq))

    (let loop ()
      (when (and (not (deque-empty? dq))
                 (<= (vector-ref nums-vec (deque-back dq)) (vector-ref nums-vec i)))
        (deque-pop-back! dq)
        (loop)))

    (deque-push-back! dq i)

    (when (>= i (- k 1))
      (set! result-acc (cons (vector-ref nums-vec (deque-front dq)) result-acc))))

  (reverse result-acc))