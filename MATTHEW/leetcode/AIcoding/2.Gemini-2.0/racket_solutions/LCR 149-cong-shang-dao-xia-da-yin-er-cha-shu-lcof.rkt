(define (recordLights lights)
  (define (helper lights acc prev)
    (cond [(empty? lights) acc]
          [(equal? (first lights) prev) (helper (rest lights) acc prev)]
          [else (helper (rest lights) (append acc (list (first lights))) (first lights))]))
  (if (empty? lights)
      '()
      (helper (rest lights) (list (first lights)) (first lights))))