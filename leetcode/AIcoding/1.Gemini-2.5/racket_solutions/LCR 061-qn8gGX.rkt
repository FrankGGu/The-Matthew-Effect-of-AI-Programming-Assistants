#lang racket

(require racket/heap)

(define (k-smallest-pairs nums1 nums2 k)
  (define v1 (list->vector nums1))
  (define v2 (list->vector nums2))
  (define len1 (vector-length v1))
  (define len2 (vector-length v2))

  (define result '())
  (define h (make-heap (lambda (a b) (< (car a) (car b))))) ; Heap stores (sum num1_idx num2_idx)

  (for ([i (in-range (min k len1))])
    (define val1 (vector-ref v1 i))
    (define val2_0 (vector-ref v2 0))
    (heap-add! h (list (+ val1 val2_0) i 0)))

  (let loop ([count 0])
    (when (and (< count k) (not (heap-empty? h)))
      (define current-pair-info (heap-extract-min! h))
      (define num1-idx (cadr current-pair-info))
      (define num2-idx (caddr current-pair-info))

      (define current-num1 (vector-ref v1 num1-idx))
      (define current-num2 (vector-ref v2 num2-idx))
      (set! result (cons (list current-num1 current-num2) result))

      (define next-num2-idx (+ num2-idx 1))
      (when (< next-num2-idx len2)
        (define next-num2-val (vector-ref v2 next-num2-idx))
        (heap-add! h (list (+ current-num1 next-num2-val) num1-idx next-num2-idx)))
      (loop (+ count 1))))

  (reverse result))