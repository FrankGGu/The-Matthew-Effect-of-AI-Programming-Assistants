(define (minLevels levels)
  (define (dp n)
    (define (helper i)
      (if (>= i n)
          0
          (let ((take (+ (list-ref levels i) (helper (+ i 1))))
                (skip (helper (+ i 1))))
            (max take skip))))
    (helper 0))
  (dp (length levels)))

(minLevels (vector 1 2 3 4 5)) ; Example input