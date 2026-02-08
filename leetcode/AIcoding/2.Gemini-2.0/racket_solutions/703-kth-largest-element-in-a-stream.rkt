(define KthLargest
  (struct kth-largest (k nums) #:mutable #:transparent))

(define (kth-largest k nums)
  (let ([heap (make-heap <)])
    (for ([num (in-list nums)])
      (heap-add! heap num))
    (while (> (heap-count heap) k)
      (heap-remove-min! heap))
    (kth-largest k heap)))

(define (kth-largest-add-val kth-largest val)
  (let ([k (kth-largest-k kth-largest)]
        [heap (kth-largest-nums kth-largest)])
    (heap-add! heap val)
    (while (> (heap-count heap) k)
      (heap-remove-min! heap))
    (heap-min heap)))