(define (minimum-time toComplete trips)
  (define (canCompleteInTime time)
    (define totalTrips (apply + (map (lambda (x) (quotient time x)) trips)))
    (>= totalTrips toComplete))

  (define (binary-search left right)
    (if (= left right)
        left
        (let* ((mid (quotient (+ left right) 2)))
          (if (canCompleteInTime mid)
              (binary-search left mid)
              (binary-search (+ mid 1) right)))))

  (binary-search 1 (* (apply max trips) toComplete))
)