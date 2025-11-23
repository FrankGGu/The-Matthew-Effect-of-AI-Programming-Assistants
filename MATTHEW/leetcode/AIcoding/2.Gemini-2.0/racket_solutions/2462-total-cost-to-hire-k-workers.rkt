(define (total-cost costs k candidates)
  (define n (length costs))
  (define left-heap (mutable-heap <))
  (define right-heap (mutable-heap <))
  (define left-idx 0)
  (define right-idx (- n 1))
  (define cost 0)

  (for ([i (in-range (min candidates n))])
    (heap-add! left-heap (list (list-ref costs i) i))
    (set! left-idx (+ left-idx 1)))

  (for ([i (in-range (min candidates n))])
    (when (< left-idx (+ n (- candidates) 1))
      (heap-add! right-heap (list (list-ref costs right-idx) right-idx))
      (set! right-idx (- right-idx 1))))

  (for ([i (in-range k)])
    (cond
      [(and (heap-empty? left-heap) (heap-empty? right-heap))
       (void)]
      [(heap-empty? left-heap)
       (let ([right-min (heap-remove-min! right-heap)])
         (set! cost (+ cost (car right-min)))))
      [(heap-empty? right-heap)
       (let ([left-min (heap-remove-min! left-heap)])
         (set! cost (+ cost (car left-min)))))
      [else
       (let ([left-min (heap-peek-min left-heap)]
             [right-min (heap-peek-min right-heap)])
         (if (< (car left-min) (car right-min))
             (let ([left-min (heap-remove-min! left-heap)])
               (set! cost (+ cost (car left-min)))
               (when (< left-idx (+ n (- candidates) 1))
                 (heap-add! left-heap (list (list-ref costs left-idx) left-idx))
                 (set! left-idx (+ left-idx 1))))
             (let ([right-min (heap-remove-min! right-heap)])
               (set! cost (+ cost (car right-min)))
               (when (< left-idx (+ n (- candidates) 1))
                 (heap-add! right-heap (list (list-ref costs right-idx) right-idx))
                 (set! right-idx (- right-idx 1)))))]))

  cost)