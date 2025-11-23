(define (sort-even-odd nums)
  (let* ([even-indices (filter-map (lambda (i v) (if (even? i) v #f)) (range (length nums)) nums)]
         [odd-indices (filter-map (lambda (i v) (if (odd? i) v #f)) (range (length nums)) nums)]
         [sorted-even (sort even-indices <)]
         [sorted-odd (sort odd-indices >)]
         [result (make-vector (length nums))])
    (for ([i (in-range (length sorted-even))])
      (vector-set! result (* 2 i) (list-ref sorted-even i)))
    (for ([i (in-range (length sorted-odd))])
      (vector-set! result (+ 1 (* 2 i)) (list-ref sorted-odd i)))
    (vector->list result)))