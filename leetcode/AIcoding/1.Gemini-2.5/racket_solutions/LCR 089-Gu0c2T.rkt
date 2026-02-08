(define (rob nums)
  (define-values (prev-max current-max)
    (for/fold ([prev-max 0]
               [current-max 0])
              ([num (in-list nums)])
      (let ([temp-current-max current-max])
        (values temp-current-max (max (+ prev-max num) current-max)))))
  current-max)