(define (score-of-parentheses s)
  (let loop ([s s] [stack (list 0)])
    (cond
      [(null? s) (car stack)]
      [(char=? (car s) #\()
       (loop (cdr s) (cons 0 stack))]
      [else
       (let* ([top (car stack)]
              [new-top (if (zero? top) 1 (* 2 top))]
              [stack (cdr stack)]
              [stack (cons (+ new-top (car stack)) (cdr stack))])
         (loop (cdr s) stack))])))