(define (k-closest-points points k)
  (define heap (make-heap (lambda (p1 p2) (< (distance p1) (distance p2)))))

  (define (distance p)
    (+ (expt (car p) 2) (expt (cadr p) 2)))

  (for ([p points])
    (heap-add! heap p))

  (define result '())
  (for ([i (in-range k)])
    (set! result (cons (heap-remove-min! heap) result)))

  (reverse result))