(define (min-operations nums k)
  (let loop ([heap (make-heap (lambda (a b) (< a b)))]
             [steps 0])
    (heap-add-all heap nums)
    (let ([smallest (heap-min heap)])
      (if (>= smallest k)
          steps
          (let ([second-smallest (heap-min heap)])
            (heap-remove-min! heap)
            (heap-remove-min! heap)
            (heap-add! heap (+ (* smallest 2) second-smallest))
            (loop heap (add1 steps)))))))