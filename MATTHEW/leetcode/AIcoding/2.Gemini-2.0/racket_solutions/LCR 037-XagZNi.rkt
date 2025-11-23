(define (asteroid-collision asteroids)
  (define (collide stack asteroid)
    (cond
      [(empty? stack) (cons asteroid stack)]
      [(and (> (car stack) 0) (< asteroid 0))
       (cond
         [(> (car stack) (- asteroid)) (cons (car stack) (cdr stack))]
         [(= (car stack) (- asteroid)) (cdr stack)]
         [else (collide (cdr stack) asteroid)])]
      [else (cons asteroid stack)]))

  (reverse (foldl collide '() asteroids)))