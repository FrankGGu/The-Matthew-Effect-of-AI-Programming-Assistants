#lang racket

(define (minSwaps nums1-list nums2-list)
  (define n (length nums1-list))

  (define nums1 (list->vector nums1-list))
  (define nums2 (list->vector nums2-list))

  (define inf (expt 10 9))

  (define dp0 (make-vector n inf))
  (define dp1 (make-vector n inf))

  (vector-set! dp0 0 0)
  (vector-set! dp1 0 1)

  (for ([i (in-range 1 n)])
    (define prev1 (vector-ref nums1 (- i 1)))
    (define prev2 (vector-ref nums2 (- i 1)))
    (define curr1 (vector-ref nums1 i))
    (define curr2 (vector-ref nums2 i))

    (when (and (> curr1 prev1) (> curr2 prev2))
      (vector-set! dp0 i (min (vector-ref dp0 i) (vector-ref dp0 (- i 1)))))

    (when (and (> curr1 prev2) (> curr2 prev1))
      (vector-set! dp0 i (min (vector-ref dp0 i) (vector-ref dp1 (- i 1)))))

    (when (and (> curr2 prev1) (> curr1 prev2))
      (vector-set! dp1 i (min (vector-ref dp1 i) (+ (vector-ref dp0 (- i 1)) 1))))

    (when (and (> curr2 prev2) (> curr1 prev1))
      (vector-set! dp1 i (min (vector-ref dp1 i) (+ (vector-ref dp1 (- i 1)) 1))))
    )

  (define result (min (vector-ref dp0 (- n 1)) (vector-ref dp1 (- n 1))))

  (if (= result inf)
      -1
      result))