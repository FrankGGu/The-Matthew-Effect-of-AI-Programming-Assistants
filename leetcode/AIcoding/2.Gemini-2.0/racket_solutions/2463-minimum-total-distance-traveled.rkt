(define (minimum-total-distance-traveled robots factories)
  (define (calculate-distance robot factory)
    (abs (- robot factory)))

  (define (solve robots factories current-distance)
    (cond
      [(null? robots) current-distance]
      [(null? factories) +inf.0]
      [else
       (let ([robot (car robots)]
             [remaining-robots (cdr robots)])
         (apply min
                (map (lambda (factory)
                       (solve remaining-robots (cdr factories) (+ current-distance (calculate-distance robot factory))))
                     factories)))]))

  (solve (sort robots <) (sort factories <) 0))