(define (minEatingSpeed piles h)
  (define (possible? k)
    (define (count-hours pile)
      (ceiling (/ pile k)))
    (<= (apply + (map count-hours piles)) h))

  (let loop ((left 1) (right (apply max piles)))
    (if (> left right)
        left
        (let ((mid (floor (/ (+ left right) 2))))
          (if (possible? mid)
              (loop left (- mid 1))
              (loop (+ mid 1) right))))))