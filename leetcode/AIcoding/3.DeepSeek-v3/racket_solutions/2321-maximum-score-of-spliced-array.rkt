#lang racket

(define (maximums-of-arrays nums1 nums2)
  (define (kadane arr1 arr2)
    (let loop ([i 1] [current (- (list-ref arr2 0) (list-ref arr1 0))] [max-so-far (- (list-ref arr2 0) (list-ref arr1 0))])
      (if (= i (length arr1))
          max-so-far
          (let ([diff (- (list-ref arr2 i) (list-ref arr1 i))])
            (loop (add1 i) 
                  (max diff (+ current diff)) 
                  (max max-so-far (max diff (+ current diff))))))))
  (let ([sum1 (apply + nums1)]
        [sum2 (apply + nums2)]
        [max-diff1 (kadane nums1 nums2)]
        [max-diff2 (kadane nums2 nums1)])
    (max sum1 sum2 (+ sum1 max-diff1) (+ sum2 max-diff2))))

(define (maximums-of-arrays-wrapper nums1 nums2)
  (maximums-of-arrays nums1 nums2))