(require data/heap)

(define (remove-stones-to-minimize-total piles k)
  (define h (make-heap >))

  (for-each (lambda (p) (heap-add! h p)) piles)

  (for-each (lambda (i)
              (when (not (heap-empty? h))
                (define current-max (heap-extract-top! h))
                (define stones-to-remove (floor (/ current-max 2)))
                (define new-pile-size (- current-max stones-to-remove))
                (heap-add! h new-pile-size)))
            (build-list k (lambda (x) x)))

  (define total-stones 0)
  (for-each (lambda (p) (set! total-stones (+ total-stones p))) (heap->list h))
  total-stones)