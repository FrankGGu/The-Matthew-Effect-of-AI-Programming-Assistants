#lang racket

(require data/heap)

(define (maximize-sum-of-squares nums k)
  ;; Create a min-heap and insert negative values to simulate a max-heap.
  ;; The smallest negative value corresponds to the largest positive value.
  (define h (make-heap))
  (for-each (lambda (num) (heap-add! h (- num))) nums)

  ;; Apply k operations
  (for ([_ (in-range k)])
    (when (not (heap-empty? h))
      ;; Extract the largest current number (smallest negative)
      (define current-max-neg (heap-extract-min! h))
      (define current-max-val (- current-max-neg))

      ;; Apply the operation: ceil(num / 2)
      (define next-val (ceiling (/ current-max-val 2)))

      ;; Insert the new value back into the heap (as negative)
      (heap-add! h (- next-val))))

  ;; Calculate the sum of squares of all remaining elements in the heap
  (define sum-squares 0)
  (while (not (heap-empty? h))
    (define neg-num (heap-extract-min! h))
    (define num (- neg-num))
    (set! sum-squares (+ sum-squares (* num num))))

  sum-squares)