(define (flip-columns-for-maximum-number-of-equal-rows matrix)
  (if (empty? matrix)
      0
      (let ((pattern-counts (make-hash)))
        (for-each (lambda (row)
                    (let* ((first-element (car row))
                           (normalized-row (if (= first-element 1)
                                               (map (lambda (x) (- 1 x)) row)
                                               row)))
                      (hash-set! pattern-counts
                                 normalized-row
                                 (+ 1 (hash-ref pattern-counts normalized-row 0)))))
                  matrix)
        (if (hash-empty? pattern-counts)
            0
            (apply max (hash-values pattern-counts))))))