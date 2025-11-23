(define (calculate-robot moves)
  (define (helper moves)
    (if (null? moves)
        0
        (let* ((move (car moves))
               (rest (cdr moves)))
          (cond
            ((equal? move 0) (+ 1 (helper rest)))
            ((equal? move 1) (+ 2 (helper rest)))
            ((equal? move 2) (+ 3 (helper rest)))
            ((equal? move 3) (+ 4 (helper rest)))
            (else (+ 5 (helper rest)))))))
  (helper moves))

(define (calculate moves)
  (calculate-robot moves))