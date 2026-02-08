(define/contract (asteroids-destroyed mass asteroids)
  (-> exact-integer? (listof exact-integer?) boolean?)
  (let loop ([current-mass mass]
              [sorted-asteroids (sort asteroids <)])
    (cond
      [(null? sorted-asteroids) #t]
      [(> current-mass (car sorted-asteroids))
       (loop (+ current-mass (car sorted-asteroids)) (cdr sorted-asteroids))]
      [else #f])))