#lang racket

(define (common-elements nums1 nums2)
  (define set1 (list->set nums1))
  (define set2 (list->set nums2))
  (set->list (set-intersect set1 set2)))