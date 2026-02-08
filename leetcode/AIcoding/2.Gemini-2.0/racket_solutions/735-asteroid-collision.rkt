(define (asteroid-collision asteroids)
  (let loop ((asteroids asteroids) (stack '()))
    (cond
      [(empty? asteroids) (reverse stack)]
      [else
       (let ((asteroid (car asteroids)))
         (cond
           [(empty? stack) (loop (cdr asteroids) (cons asteroid stack))]
           [(and (> asteroid 0) (< (car stack) 0)) (loop (cdr asteroids) (cons asteroid stack))]
           [(and (< asteroid 0) (> (car stack) 0))
            (cond
              [(> (car stack) (- asteroid)) (loop (cdr asteroids) stack)]
              [(= (car stack) (- asteroid)) (loop (cdr asteroids) (cdr stack))]
              [else (loop (cons asteroid (cdr asteroids)) (cdr stack))])]
           [else (loop (cdr asteroids) (cons asteroid stack))]))])))