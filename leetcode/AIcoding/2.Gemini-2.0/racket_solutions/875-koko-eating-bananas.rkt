(define (min-eating-speed piles h)
  (define (possible? speed)
    (define (calculate-hours pile)
      (ceiling (/ pile speed)))
    (define total-hours (apply + (map calculate-hours piles)))
    (<= total-hours h))

  (define (binary-search left right)
    (if (> left right)
        left
        (let ((mid (floor (/ (+ left right) 2))))
          (if (possible? mid)
              (binary-search left (- mid 1))
              (binary-search (+ mid 1) right)))))

  (define max-pile (apply max piles))
  (binary-search 1 max-pile))