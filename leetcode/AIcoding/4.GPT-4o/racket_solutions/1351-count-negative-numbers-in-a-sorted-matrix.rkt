(define (countNegatives matrix)
  (define (count-in-row row)
    (let loop ((idx (length row)) (count 0))
      (if (zero? idx)
          count
          (if (< (list-ref row (- idx 1)) 0)
              (loop (- idx 1) (+ count 1))
              (loop (- idx 1) count)))))
  (foldl (lambda (row acc) (+ (count-in-row row) acc)) 0 matrix))