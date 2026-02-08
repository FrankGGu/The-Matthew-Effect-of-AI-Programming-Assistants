(define (get-shortest-distance words target startIndex)
  (let* ([n (length words)]
         [min-dist n]) ; Initialize with a value larger than any possible distance
    (for ([i (in-range n)])
      (let ([current-clockwise-index (modulo (+ startIndex i) n)]
            [current-counter-clockwise-index (modulo (- startIndex i) n)])

        (when (string=? (list-ref words current-clockwise-index) target)
          (set! min-dist (min min-dist i)))

        (when (string=? (list-ref words current-counter-clockwise-index) target)
          (set! min-dist (min min-dist i)))))
    min-dist))