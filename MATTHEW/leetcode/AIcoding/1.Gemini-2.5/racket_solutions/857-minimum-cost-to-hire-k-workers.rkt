#lang racket

(require data/heap)

(define (min-cost-to-hire-k-workers wage quality k)
  (define n (length wage))

  ; Create a list of (ratio, quality) pairs for each worker.
  ; ratio = wage / quality. Use inexact numbers for floating-point division.
  (define workers
    (for/list ([w wage] [q quality])
      (cons (/ (exact->inexact w) (exact->inexact q)) q)))

  ; Sort workers by their ratio in ascending order.
  (define sorted-workers
    (sort workers (lambda (a b) (< (car a) (car b)))))

  ; Initialize minimum cost to positive infinity.
  (define min-cost +inf.0)

  ; Initialize total quality of the K workers currently in the group.
  (define total-quality 0)

  ; Create a max-heap to store the qualities of the K workers.
  ; We use `>` as the comparison function for `make-heap` to create a max-heap.
  (define quality-heap (make-heap >))

  ; Iterate through the workers sorted by ratio.
  (for ([worker sorted-workers])
    (define current-ratio (car worker))
    (define current-quality (cdr worker))

    ; Add the current worker's quality to the heap and update total-quality.
    (heap-add! quality-heap current-quality)
    (set! total-quality (+ total-quality current-quality))

    ; If the heap size exceeds K, remove the worker with the highest quality
    ; (which is the root of the max-heap) to maintain K workers with the
    ; smallest qualities for the current ratio.
    (when (> (heap-count quality-heap) k)
      (define q-max (heap-extract-max! quality-heap))
      (set! total-quality (- total-quality q-max)))

    ; If the heap now contains exactly K workers, calculate the cost
    ; and update the minimum cost found so far.
    (when (= (heap-count quality-heap) k)
      (define current-cost (* current-ratio total-quality))
      (set! min-cost (min min-cost current-cost))))

  min-cost)