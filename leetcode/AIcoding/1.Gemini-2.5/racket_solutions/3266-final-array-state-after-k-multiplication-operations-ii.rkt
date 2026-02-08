#lang racket

(define (swap! vec i j)
  (let ([temp (vector-ref vec i)])
    (vector-set! vec i (vector-ref vec j))
    (vector-set! vec j temp)))

(define (heapify-down! vec len idx)
  (let loop ([i idx])
    (let* ([left (+ (* 2 i) 1)]
           [right (+ (* 2 i) 2)]
           [largest i])
      ;; Check left child
      (when (and (< left len) (> (vector-ref vec left) (vector-ref vec largest)))
        (set! largest left))
      ;; Check right child
      (when (and (< right len) (> (vector-ref vec right) (vector-ref vec largest)))
        (set! largest right))

      ;; If largest is not current node, swap and continue heapifying down
      (when (not (= largest i))
        (swap! vec i largest)
        (loop largest))))))

(define (maximize-sum nums k)
  (define n (length nums))
  (define heap (make-vector n))

  ;; Initialize heap vector with elements from nums list
  (for ([i (in-range n)])
    (vector-set! heap i (list-ref nums i)))

  ;; Build max-heap in O(N) time
  ;; Start from the last parent node and go up to the root
  (for ([i (in-range (quotient (- n 1) 2) -1 -1)])
    (heapify-down! heap n i))

  ;; Perform k operations
  ;; In each operation, extract the maximum element (root),
  ;; multiply it by 2, and then re-insert it (by replacing the root
  ;; and heapifying down to restore the heap property).
  (for ([_ (in-range k)])
    (let ([max-val (vector-ref heap 0)])
      (vector-set! heap 0 (* max-val 2)) ; Replace root with multiplied value
      (heapify-down! heap n 0))) ; Restore heap property from the root

  ;; Calculate the sum of all elements remaining in the heap
  (apply + (vector->list heap)))