(define (countTestedDevices batteryPercentages)
  (let loop ([bps batteryPercentages] [tested 0])
    (cond
      [(empty? bps) tested]
      [else
       (let ([first-bp (first bps)]
             [rest-bps (rest bps)])
         (if (> first-bp 0)
             (loop (map (lambda (x) (max 0 (- x 1))) rest-bps) (+ tested 1))
             (loop rest-bps tested)))])))