(define (count-tested-devices batteryPercentages)
  (let loop ((devices batteryPercentages)
             (tested-count 0))
    (if (empty? devices)
        tested-count
        (let ((current-battery (car devices)))
          (if (> (- current-battery tested-count) 0)
              (loop (cdr devices) (+ tested-count 1))
              (loop (cdr devices) tested-count))))))