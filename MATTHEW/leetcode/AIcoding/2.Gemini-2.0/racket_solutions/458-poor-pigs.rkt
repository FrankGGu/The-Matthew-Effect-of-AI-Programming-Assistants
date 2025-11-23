(define (poor-pigs buckets minutesToDie minutesToTest)
  (let ((trials (quotient minutesToTest minutesToDie)))
    (if (= buckets 1)
        0
        (let loop ((pigs 0))
          (if (>= (expt (+ trials 1) pigs) buckets)
              pigs
              (loop (+ pigs 1)))))))