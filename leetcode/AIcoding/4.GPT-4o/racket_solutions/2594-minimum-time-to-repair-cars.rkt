(define (repairCars ranks cars)
  (define (canFinish time)
    (for/sum ([rank ranks])
      (floor (/ time rank))))

  (define (binarySearch left right)
    (if (= left right)
        left
        (let ((mid (quotient (+ left right) 2)))
          (if (>= (canFinish mid) cars)
              (binarySearch left mid)
              (binarySearch (+ mid 1) right)))))

  (binarySearch 1 (* (apply max ranks) cars)))