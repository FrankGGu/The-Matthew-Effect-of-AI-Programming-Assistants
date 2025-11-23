#lang racket

(define (min-equal-sum nums1 nums2)
  (define (sum-zeroes lst)
    (for/sum ([x lst] #:when (= x 0)) 1))
  (define (count-zeroes lst)
    (length (filter (lambda (x) (= x 0)) lst)))
  (define z1 (count-zeroes nums1))
  (define z2 (count-zeroes nums2))
  (if (or (= z1 0) (= z2 0))
      (let ([s1 (apply + nums1)]
            [s2 (apply + nums2)])
        (if (> s1 s2)
            (+ s1 (* z2 1))
            (+ s2 (* z1 1))))
      (let ([s1 (apply + nums1)]
            [s2 (apply + nums2)])
        (let ([diff (abs (- s1 s2))])
          (if (>= diff (max z1 z2))
              (+ (max s1 s2) (abs (- z1 z2)))
              (max s1 s2))))))