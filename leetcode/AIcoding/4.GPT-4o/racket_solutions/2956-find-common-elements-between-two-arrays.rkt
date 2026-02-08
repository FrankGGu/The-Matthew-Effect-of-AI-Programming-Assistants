#lang racket

(define (intersection nums1 nums2)
  (define set1 (set nums1))
  (define set2 (set nums2))
  (set->list (set-intersect set1 set2)))

(intersection '(1 2 2 1) '(2 2))