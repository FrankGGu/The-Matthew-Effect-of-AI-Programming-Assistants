(define (poor-pigs buckets minutesToDie minutesToTest)
  (let* ((rounds (+ (/ minutesToTest minutesToDie) 1)))
    (if (= buckets 1)
        0
        (let loop ((pigs 0) (power 1))
          (if (>= power buckets)
              pigs
              (loop (+ pigs 1) (* power rounds)))))))