(define (asteroid-collision asteroids)
  (let loop ((stack '()) (remaining asteroids))
    (cond
      ((empty? remaining)
       (reverse stack))
      (else
       (let* ((current (car remaining))
              (rest (cdr remaining)))
         (cond
           ((or (empty? stack)
                (> current 0)
                (< (car stack) 0))
            (loop (cons current stack) rest))
           (else
            (let ((top (car stack)))
              (cond
                ((> (abs current) (abs top))
                 (loop (cdr stack) remaining))
                ((< (abs current) (abs top))
                 (loop stack rest))
                (else
                 (loop (cdr stack) rest))))))))))