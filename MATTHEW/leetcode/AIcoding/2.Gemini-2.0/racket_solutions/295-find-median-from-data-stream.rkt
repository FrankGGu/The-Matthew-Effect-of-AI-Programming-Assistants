(define median-finder%
  (class object%
    (init)
    (super-new)

    (define max-heap (make-heap < #:immutable #t)) ; Stores the smaller half
    (define min-heap (make-heap > #:immutable #t)) ; Stores the larger half

    (define/public (add-num num)
      (heap-add! max-heap num)
      (heap-add! min-heap (heap-remove-min! max-heap))
      (when (> (heap-count max-heap) (heap-count min-heap))
        (heap-add! max-heap (heap-remove-min! min-heap))))

    (define/public (find-median)
      (if (= (heap-count max-heap) (heap-count min-heap))
          (/ (+ (heap-min max-heap) (heap-min min-heap)) 2.0)
          (heap-min max-heap)))
    ))

(define (make-median-finder)
  (new median-finder%))