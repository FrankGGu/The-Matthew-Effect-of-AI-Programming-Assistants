(define (flip-and-invert-image image)
  (define (invert x)
    (if (= x 0) 1 0))

  (define (process-row row)
    (map invert (reverse row)))

  (map process-row image))