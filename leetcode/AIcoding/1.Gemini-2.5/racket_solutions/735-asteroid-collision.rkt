(define (asteroid-collision asteroids)
  (define (process-asteroid stack current-asteroid)
    (cond
      ;; If the stack is empty, or the current asteroid moves right,
      ;; or the top of the stack moves left (no collision possible with current-asteroid),
      ;; push the current asteroid onto the stack.
      ((or (empty? stack)
           (> current-asteroid 0)
           (< (car stack) 0))
       (cons current-asteroid stack))

      ;; Collision scenario: current-asteroid moves left and top of stack moves right.
      ;; (car stack) > 0 and current-asteroid < 0
      (else
       (let loop ((s stack))
         (cond
           ;; If the stack becomes empty or the top of the stack is moving left,
           ;; no more right-moving asteroids to collide with. Push current-asteroid.
           ((or (empty? s)
                (< (car s) 0))
            (cons current-asteroid s))

           ;; If the top of the stack moves right and is smaller than the current-asteroid,
           ;; the top-asteroid is destroyed. Continue checking with the rest of the stack.
           ((< (car s) (abs current-asteroid))
            (loop (cdr s)))

           ;; If the top of the stack moves right and has the same size as the current-asteroid,
           ;; both are destroyed. Current-asteroid is destroyed, so return the rest of the stack.
           ((= (car s) (abs current-asteroid))
            (cdr s))

           ;; If the top of the stack moves right and is larger than the current-asteroid,
           ;; the current-asteroid is destroyed. Return the stack as is.
           (else ; (> (car s) (abs current-asteroid))
            s))))))

  ;; Use for/fold to iterate through the asteroids and build the result stack.
  ;; The stack is built in reverse order, so a final reverse is needed.
  (reverse (for/fold ((stack '()))
                     ((asteroid asteroids))
    (process-asteroid stack asteroid))))