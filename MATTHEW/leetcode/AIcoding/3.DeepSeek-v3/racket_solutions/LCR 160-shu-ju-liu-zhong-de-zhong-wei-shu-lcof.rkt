(define median-finder%
  (class object%
    (super-new)
    (init-field)
    (define max-heap (make-heap (λ (a b) (> a b))))
    (define min-heap (make-heap (λ (a b) (< a b))))

    (define/public (add-num num)
      (heap-add! max-heap num)
      (heap-add! min-heap (heap-extremum max-heap))
      (heap-remove-extremum! max-heap)
      (when (< (heap-count max-heap) (heap-count min-heap))
        (heap-add! max-heap (heap-extremum min-heap))
        (heap-remove-extremum! min-heap)))

    (define/public (find-median)
      (if (> (heap-count max-heap) (heap-count min-heap))
          (heap-extremum max-heap)
          (/ (+ (heap-extremum max-heap) (heap-extremum min-heap)) 2.0))))