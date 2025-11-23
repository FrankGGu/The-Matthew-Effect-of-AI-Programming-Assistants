#lang racket

(define (find-ec (nums1 #:list nums1) (nums2 #:list nums2))
  (define s1 (set . nums1))
  (define s2 (set . nums2))
  (define common (set-intersect s1 s2))
  (if (set-empty? common)
      -1
      (apply min (set->list common))))