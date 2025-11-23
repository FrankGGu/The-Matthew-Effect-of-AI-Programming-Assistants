(define (judge-circle moves)
  (define (helper moves x y)
    (cond
      [(empty? moves) (and (= x 0) (= y 0))]
      [else
       (let ((move (car moves)))
         (cond
           [(equal? move #\U) (helper (cdr moves) x (+ y 1))]
           [(equal? move #\D) (helper (cdr moves) x (- y 1))]
           [(equal? move #\L) (helper (cdr moves) (- x 1) y)]
           [(equal? move #\R) (helper (cdr moves) (+ x 1) y)]
           [else #f]))]))
  (helper (string->list moves) 0 0))