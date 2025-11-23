#lang racket

(define (longest-non-decreasing-subarray-from-two-arrays nums1 nums2)
  (define n (length nums1))

  (when (= n 0)
    (error "Input arrays cannot be empty"))

  (define vec1 (list->vector nums1))
  (define vec2 (list->vector nums2))

  (define current-max-len 1)
  (define prev-dp0 1)
  (define prev-dp1 1)

  (for ([i (in-range 1 n)])
    (define num1-i (vector-ref vec1 i))
    (define num2-i (vector-ref vec2 i))
    (define num1-prev (vector-ref vec1 (- i 1)))
    (define num2-prev (vector-ref vec2 (- i 1)))

    (define current-dp0 1)
    (define current-dp1 1)

    (when (>= num1-i num1-prev)
      (set! current-dp0 (max current-dp0 (+ prev-dp0 1))))
    (when (>= num1-i num2-prev)
      (set! current-dp0 (max current-dp0 (+ prev-dp1 1))))

    (when (>= num2-i num1-prev)
      (set! current-dp1 (max current-dp1 (+ prev-dp0 1))))
    (when (>= num2-i num2-prev)
      (set! current-dp1 (max current-dp1 (+ prev-dp1 1))))

    (set! current-max-len (max current-max-len current-dp0 current-dp1))

    (set! prev-dp0 current-dp0)
    (set! prev-dp1 current-dp1))

  current-max-len)