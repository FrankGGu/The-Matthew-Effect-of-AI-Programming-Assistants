(define (robot (width height commands start)
  (let loop ([x (car start)] [y (cadr start)] [commands commands])
    (cond
      [(null? commands) #t]
      [(string=? (car commands) "U")
       (let ([new-y (+ y 1)])
         (if (>= new-y height)
             #f
             (loop x new-y (cdr commands))))]
      [(string=? (car commands) "D")
       (let ([new-y (- y 1)])
         (if (< new-y 0)
             #f
             (loop x new-y (cdr commands))))]
      [(string=? (car commands) "L")
       (let ([new-x (- x 1)])
         (if (< new-x 0)
             #f
             (loop new-x y (cdr commands))))]
      [(string=? (car commands) "R")
       (let ([new-x (+ x 1)])
         (if (>= new-x width)
             #f
             (loop new-x y (cdr commands))))]
      [else #f])))