(define (asteroidCollision asteroids)
  (define result '())
  (define (process-asteroid a)
    (cond
      ((null? result) (set! result (list a)))
      ((and (> a 0) (null? result)) (set! result (list a)))
      ((> a 0) (set! result (cons a result)))
      ((< a 0)
       (let loop ()
         (if (null? result)
             (set! result (list a))
             (let ((last (car result)))
               (cond
                 ((> last 0) (set! result (cons a (cdr result))))
                 ((= last (abs a)) (set! result (cdr result)))
                 ((< last (abs a)) (begin
                                    (set! result (cdr result))
                                    (loop)))
                 (else (set! result (cons last (cdr result)))))))))))
  (for-each process-asteroid asteroids)
  (reverse result))

(asteroidCollision '(5 10 -5)) ; Example input