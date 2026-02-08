#lang racket

(require data/heap)

(define-struct kth-largest (k heap))

(define (kth-largest-new k nums)
  (let ((kl (make-kth-largest k (make-min-heap))))
    (for-each (lambda (num) (kth-largest-add kl num)) nums)
    kl))

(define (kth-largest-add kl val)
  (let* ((k (kth-largest-k kl))
         (heap (kth-largest-heap kl)))
    (heap-add! heap val)
    (when (> (heap-size heap) k)
      (heap-remove-min! heap))
    (heap-min-val heap)))