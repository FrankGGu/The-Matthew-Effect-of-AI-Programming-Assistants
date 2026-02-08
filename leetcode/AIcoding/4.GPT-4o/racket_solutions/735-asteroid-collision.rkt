(define (asteroidCollision asteroids)
  (define stack '())
  (for-each (lambda (asteroid)
              (cond
                [(= asteroid 0) (set! stack (cons 0 stack))]
                [(and (positive? asteroid) (or (null? stack) (positive? (car stack)))) 
                 (set! stack (cons asteroid stack))]
                [(and (negative? asteroid) (not (null? stack)) (positive? (car stack)))
                 (let loop ((s stack))
                   (cond
                     [(null? s) (set! stack (cons asteroid '()))]
                     [(> (car s) (abs asteroid)) (set! stack s)]
                     [(= (car s) (abs asteroid)) (set! stack (cdr s))]
                     [else (loop (cdr s))]))]
                [(and (negative? asteroid) (not (null? stack)) (negative? (car stack)))
                 (set! stack (cons asteroid stack))])))
  (reverse stack))