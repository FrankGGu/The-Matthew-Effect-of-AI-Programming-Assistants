#lang racket

(require data/heap)

(define (k-smallest-pairs nums1 nums2 k)
  (let* ([len1 (length nums1)]
         [len2 (length nums2)])

    (define min-heap (make-heap (lambda (a b) (< (car a) (car b))))) ; Heap stores (sum i j)

    ;; Initialize heap with (nums1[i] + nums2[0], i, 0) for i from 0 to min(k-1, len1-1)
    ;; This ensures we start with the smallest possible sums for each element in nums1
    ;; paired with the first element of nums2.
    (for ([i (in-range (min k len1))])
      (heap-add! min-heap (list (+ (list-ref nums1 i) (list-ref nums2 0)) i 0)))

    (define result '())
    (define count 0)

    (while (and (< count k) (not (heap-empty? min-heap)))
      (let* ([current-item (heap-min-pop! min-heap)]
             [i (cadr current-item)]
             [j (caddr current-item)])

        (set! result (cons (list (list-ref nums1 i) (list-ref nums2 j)) result))
        (set! count (+ count 1))

        ;; If there's a next element in nums2 for the current nums1[i], add it to the heap.
        ;; This explores the next smallest sum involving nums1[i].
        (when (< (+ j 1) len2)
          (heap-add! min-heap (list (+ (list-ref nums1 i) (list-ref nums2 (+ j 1))) i (+ j 1))))))

    (reverse result)))