#lang racket

(define (min-swaps nums)
  (define n (length nums))
  (define total-ones (for/sum ([x (in-list nums)]) (if (= x 1) 1 0)))

  (when (<= total-ones 1)
    0)

  (define vec-nums (list->vector nums))
  (define extended-vec-nums (vector-append vec-nums vec-nums))

  (define current-ones-in-window 0)
  (define max-ones-in-window 0)

  (for ([k (in-range 0 total-ones)])
    (when (= (vector-ref extended-vec-nums k) 1)
      (set! current-ones-in-window (add1 current-ones-in-window))))

  (set! max-ones-in-window current-ones-in-window)

  (for ([i (in-range 1 n)])
    (when (= (vector-ref extended-vec-nums (sub1 i)) 1)
      (set! current-ones-in-window (sub1 current-ones-in-window)))

    (when (= (vector-ref extended-vec-nums (add i total-ones -1)) 1)
      (set! current-ones-in-window (add1 current-ones-in-window)))

    (set! max-ones-in-window (max max-ones-in-window current-ones-in-window)))

  (- total-ones max-ones-in-window))