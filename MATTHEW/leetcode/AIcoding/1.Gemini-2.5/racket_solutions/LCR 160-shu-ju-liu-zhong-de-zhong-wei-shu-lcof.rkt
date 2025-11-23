#lang racket

(require data/heap)

(define median-finder%
  (class object%
    (field
     [small-half (make-heap >)] ; Max-heap for the smaller half of numbers
     [large-half (make-heap <)]) ; Min-heap for the larger half of numbers

    (define/public (addNum num)
      ; Add the number to the appropriate heap
      (if (heap-empty? small-half)
          (heap-add! small-half num)
          (if (<= num (heap-min small-half)) ; heap-min on a max-heap returns the largest element
              (heap-add! small-half num)
              (heap-add! large-half num)))

      ; Balance the heaps: small-half can have at most one more element than large-half
      (when (> (heap-count small-half) (+ (heap-count large-half) 1))
        (heap-add! large-half (heap-extract-min! small-half))) ; extract largest from small-half
      (when (> (heap-count large-half) (heap-count small-half))
        (heap-add! small-half (heap-extract-min! large-half)))) ; extract smallest from large-half

    (define/public (findMedian)
      (cond
        ; If both heaps have the same number of elements, the median is the average of their roots
        [(= (heap-count small-half) (heap-count large-half))
         (/ (+ (heap-min small-half) (heap-min large-half)) 2.0)]
        ; If small-half has one more element, its root is the median
        [else
         (heap-min small-half)]))))