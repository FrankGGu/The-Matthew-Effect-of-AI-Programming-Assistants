(define/contract (total-cost costs k candidates)
  (-> (listof exact-integer?) exact-integer? exact-integer? exact-integer?)
  (define left-heap (make-heap (lambda (a b) (< a b))))
  (define right-heap (make-heap (lambda (a b) (< a b))))
  (define n (length costs))
  (define left 0)
  (define right (sub1 n))

  (for ([i candidates])
    (when (<= left right)
      (heap-add! left-heap (list-ref costs left))
      (set! left (add1 left))))

  (for ([i candidates])
    (when (<= left right)
      (heap-add! right-heap (list-ref costs right))
      (set! right (sub1 right)))))

  (define total 0)

  (for ([i k])
    (define left-min (if (heap-empty? left-heap) +inf.0 (heap-min left-heap)))
    (define right-min (if (heap-empty? right-heap) +inf.0 (heap-min right-heap)))

    (if (<= left-min right-min)
        (begin
          (set! total (+ total left-min))
          (heap-remove-min! left-heap)
          (when (<= left right)
            (heap-add! left-heap (list-ref costs left))
            (set! left (add1 left))))
        (begin
          (set! total (+ total right-min))
          (heap-remove-min! right-heap)
          (when (<= left right)
            (heap-add! right-heap (list-ref costs right))
            (set! right (sub1 right))))))
    )
  total)