(define (countTestedDevices batteryPercentages)
  (let loop ([batteries batteryPercentages]
             [count 0])
    (if (null? batteries)
        count
        (let ([current (car batteries)])
          (if (> current count)
              (loop (map (lambda (x) (if (> x count) (sub1 x) x)) (cdr batteries)) (add1 count))
              (loop (cdr batteries) count))))))