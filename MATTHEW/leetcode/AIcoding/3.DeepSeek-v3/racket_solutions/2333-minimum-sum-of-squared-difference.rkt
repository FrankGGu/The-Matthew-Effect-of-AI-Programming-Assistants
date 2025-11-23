(define/contract (min-sum-square-diff nums1 nums2 k1 k2)
  (-> (listof exact-integer?) (listof exact-integer?) exact-integer? exact-integer? exact-integer?)
  (let* ([diffs (map (lambda (x y) (abs (- x y))) nums1 nums2)]
         [total-k (+ k1 k2)]
         [max-heap (make-heap (lambda (a b) (> a b)))])
    (for ([diff diffs])
      (when (> diff 0)
        (heap-add! max-heap diff)))
    (let loop ([k total-k])
      (if (or (zero? k) (heap-empty? max-heap))
          (foldl (lambda (x acc) (+ acc (* x x))) 0 (heap->list max-heap))
          (let* ([current (heap-remove! max-heap)]
                 [next (if (zero? (sub1 current)) 0 (sub1 current))])
            (heap-add! max-heap next)
            (loop (sub1 k)))))))