(define (max-distance-between-different-colors colors)
  (let* ((n (length colors))
         (color0 (list-ref colors 0))
         (color-last (list-ref colors (- n 1)))
         (max-dist-from-0 0)
         (max-dist-from-last 0))

    (for ((j (in-range (- n 1) 0 -1)))
      (when (not (= (list-ref colors j) color0))
        (set! max-dist-from-0 j)
        (break)))

    (for ((i (in-range (- n 1))))
      (when (not (= (list-ref colors i) color-last))
        (set! max-dist-from-last (- (- n 1) i))
        (break)))

    (max max-dist-from-0 max-dist-from-last)))