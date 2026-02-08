(define/contract (asteroid-collision asteroids)
  (-> (listof exact-integer?) (listof exact-integer?))
  (define stack '())
  (for ([ast asteroids])
    (let loop ()
      (cond
        [(null? stack) (set! stack (cons ast stack))]
        [(and (> ast 0) (> (car stack) 0)) (set! stack (cons ast stack))]
        [(and (< ast 0) (< (car stack) 0)) (set! stack (cons ast stack))]
        [(and (< ast 0) (> (car stack) 0))
         (cond
           [(> (abs ast) (car stack))
            (set! stack (cdr stack))
            (if (null? stack)
                (set! stack (cons ast stack))
                (loop))]
           [(= (abs ast) (car stack)) (set! stack (cdr stack))]
           [else (void)])]
        [else (set! stack (cons ast stack))])))
  (reverse stack))