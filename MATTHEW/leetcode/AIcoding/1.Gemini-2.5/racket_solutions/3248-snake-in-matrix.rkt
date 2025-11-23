(define (snake-in-matrix matrix)
  (define (process-row row row-index)
    (if (even? row-index)
        row
        (reverse row)))

  (if (empty? matrix)
      '()
      (apply append (map process-row matrix (range (length matrix))))))