(define (asteroids-destroyed? mass asteroids)
  (define (helper mass asteroids-sorted)
    (cond
      [(empty? asteroids-sorted) #t]
      [(<= (first asteroids-sorted) mass)
       (helper (+ mass (first asteroids-sorted)) (rest asteroids-sorted))]
      [else #f]))
  (helper mass (sort asteroids <)))