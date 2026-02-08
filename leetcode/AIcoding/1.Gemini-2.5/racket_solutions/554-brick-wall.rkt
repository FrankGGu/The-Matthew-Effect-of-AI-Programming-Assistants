(define (least-bricks wall)
  (define num-rows (length wall))
  (define gap-counts (make-hash))
  (define total-wall-width (apply + (car wall)))

  (for-each (lambda (row)
              (define current-width 0)
              (for-each (lambda (brick-width)
                          (set! current-width (+ current-width brick-width))
                          (when (< current-width total-wall-width)
                            (hash-update! gap-counts current-width add1 0)))
                        row))
            wall)

  (define max-gaps 0)
  (when (> (hash-count gap-counts) 0)
    (set! max-gaps (apply max (hash-values gap-counts))))

  (- num-rows max-gaps))