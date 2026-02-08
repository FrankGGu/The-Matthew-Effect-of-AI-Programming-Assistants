#lang racket

(define (total-fruit fruits)
  (define fruit-vec (list->vector fruits))
  (define n (vector-length fruit-vec))
  (define fruit-counts (make-hash)) ; Stores counts of fruit types in the current window
  (define left 0)
  (define max-fruits 0)

  (for ([right (in-range n)])
    (define current-fruit (vector-ref fruit-vec right))

    ; Add the current fruit to the window
    (hash-update! fruit-counts current-fruit add1 0)

    ; Shrink the window from the left if more than two fruit types are present
    (while (> (hash-count fruit-counts) 2)
      (define left-fruit (vector-ref fruit-vec left))
      (hash-update! fruit-counts left-fruit sub1) ; Decrement count of the leftmost fruit
      (when (= (hash-ref fruit-counts left-fruit) 0)
        (hash-remove! fruit-counts left-fruit)) ; Remove if count becomes zero
      (set! left (+ left 1))) ; Move the left pointer to shrink the window

    ; Update the maximum number of fruits collected
    (set! max-fruits (max max-fruits (- right left -1)))) ; Current window size is (right - left + 1)

  max-fruits)