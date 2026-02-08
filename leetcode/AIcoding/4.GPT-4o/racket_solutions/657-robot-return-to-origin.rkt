(define (judgeCircle moves)
  (define x 0)
  (define y 0)
  (for-each 
    (lambda (move)
      (cond 
        [(equal? move #\U) (set! y (+ y 1))]
        [(equal? move #\D) (set! y (- y 1))]
        [(equal? move #\L) (set! x (- x 1))]
        [(equal? move #\R) (set! x (+ x 1))]))
    (string->list moves))
  (and (= x 0) (= y 0)))

(judgeCircle "UD")
(judgeCircle "LL")
(judgeCircle "RUUD")