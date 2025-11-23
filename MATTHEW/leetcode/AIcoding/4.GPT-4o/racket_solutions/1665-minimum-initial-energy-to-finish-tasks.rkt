(define (minimumInitialEnergy tasks)
  (define (energy-needed task)
    (let ([actual-energy (car task)]
          [required-energy (cadr task)])
      (max actual-energy required-energy)))
  (define (calculate-min-energy tasks)
    (let loop ([tasks tasks]
               [total-energy 0]
               [current-energy 0])
      (if (null? tasks)
          (max 1 (- total-energy current-energy))
          (let* ([task (car tasks)]
                 [actual-energy (car task)]
                 [required-energy (cadr task)]
                 [needed-energy (energy-needed task)])
            (loop (cdr tasks)
                  (+ total-energy (- needed-energy actual-energy))
                  (- current-energy actual-energy)))))))
  (calculate-min-energy tasks))