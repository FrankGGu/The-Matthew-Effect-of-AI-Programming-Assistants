(define (validate-stack-sequences pushed popped)
  (let loop ([i 0] [j 0] [stack '()])
    (cond
      [(and (= i (length pushed)) (= j (length popped)))
       (null? stack)]
      [(= i (length pushed))
       (and (not (null? stack))
            (equal? (car stack) (list-ref popped j))
            (loop i (+ j 1) (cdr stack)))]
      [else
       (if (and (not (null? stack)) (equal? (car stack) (list-ref popped j)))
           (loop i (+ j 1) (cdr stack))
           (loop (+ i 1) j (cons (list-ref pushed i) stack)))])))