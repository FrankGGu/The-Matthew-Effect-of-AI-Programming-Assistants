(define (minSpeedOnTime dist hour)
  (define (canArriveOnTime(speed)
    (define total-time 0)
    (for-each (lambda (d)
                (set! total-time (+ total-time (if (= (length dist) 1)
                                                    (/ d speed)
                                                    (ceiling (/ d speed)))))
              dist)
    (<= total-time hour))

  (define (binary-search low high)
    (if (>= low high)
        low
        (let ((mid (quotient (+ low high) 2)))
          (if (canArriveOnTime mid)
              (binary-search low mid)
              (binary-search (+ mid 1) high)))))

  (if (= hour 0) 0
      (let ((low 1)
            (high (* 10 (apply max dist))))
        (if (canArriveOnTime high)
            (binary-search low high)
            -1))))