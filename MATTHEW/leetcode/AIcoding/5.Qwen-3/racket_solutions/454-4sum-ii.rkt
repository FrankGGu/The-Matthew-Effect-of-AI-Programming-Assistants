#lang racket

(define (four-nums-sum II nums1 nums2 nums3 nums4)
  (define count (make-hash))
  (for ([a nums1])
    (for ([b nums2])
      (hash-update! count (+ a b) add1 0)))
  (define result 0)
  (for ([c nums3])
    (for ([d nums4])
      (define target (- (+ c d)))
      (when (hash-has-key? count target)
        (set! result (+ result (hash-ref count target))))))
  result)