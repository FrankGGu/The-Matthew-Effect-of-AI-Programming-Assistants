(define (max-width-ramp A)
  (define n (length A))
  (define indices (vector->list (vector (range n))))
  (define sorted-indices (sort indices (lambda (i j) (or (< (list-ref A i) (list-ref A j))
                                                  (and (= (list-ref A i) (list-ref A j))
                                                       (< i j))))))
  (define max-width 0)
  (define min-index (make-vector n #f))

  (for ([i (in-range n)])
    (when (and (not (vector-ref min-index (vector-ref sorted-indices i)))
               (vector-set! min-index (vector-ref sorted-indices i) i)))
    (for ([j (in-range i n)])
      (set! max-width (max max-width (- (vector-ref sorted-indices j) (vector-ref min-index (vector-ref sorted-indices j)))))))
  max-width)

(max-width-ramp '(6 0 8 5 3 4 2 0 7)) ; Example usage