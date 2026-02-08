#lang racket

(require racket/set)

(define (maximum-set-size nums1 nums2)
  (let* ((n (length nums1))
         (k (quotient n 2))
         (s1 (list->set nums1))
         (s2 (list->set nums2))
         (only1 (set-difference s1 s2))
         (only2 (set-difference s2 s1))
         (common (set-intersect s1 s2))
         (count-only1 (set-count only1))
         (count-only2 (set-count only2))
         (count-common (set-count common)))

    (let* ((num-taken-from-only1 (min k count-only1))
           (k-remaining-1 (- k num-taken-from-only1))
           (num-taken-from-only2 (min k count-only2))
           (k-remaining-2 (- k num-taken-from-only2)))

      (+ num-taken-from-only1
         num-taken-from-only2
         (min count-common (+ k-remaining-1 k-remaining-2))))))