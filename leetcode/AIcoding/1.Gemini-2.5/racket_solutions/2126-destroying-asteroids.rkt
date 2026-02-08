(define (asteroids-destroyed mass asteroids)
  (let loop ((current-mass mass)
             (remaining-asteroids (sort asteroids <)))
    (cond
      ((empty? remaining-asteroids) #t)
      ((>= current-mass (car remaining-asteroids))
       (loop (+ current-mass (car remaining-asteroids))
             (cdr remaining-asteroids)))
      (else #f))))