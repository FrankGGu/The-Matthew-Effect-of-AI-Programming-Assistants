(define (valid-tic-tac-toe state)
  (define board (map string->list state))
  (define x-count (count (lambda (c) (equal? c #\X)) (flatten board)))
  (define o-count (count (lambda (c) (equal? c #\O)) (flatten board)))

  (define (get-winner)
    (define (check-line line)
      (cond
        [(and (equal? (list-ref line 0) #\X) (equal? (list-ref line 1) #\X) (equal? (list-ref line 2) #\X)) #\X]
        [(and (equal? (list-ref line 0) #\O) (equal? (list-ref line 1) #\O) (equal? (list-ref line 2) #\O)) #\O]
        [else #f]))

    (define rows board)
    (define cols (map (lambda (i) (list (list-ref (list-ref board 0) i) (list-ref (list-ref board 1) i) (list-ref (list-ref board 2) i))) '(0 1 2)))
    (define diags (list (list (list-ref (list-ref board 0) 0) (list-ref (list-ref board 1) 1) (list-ref (list-ref board 2) 2))
                       (list (list-ref (list-ref board 0) 2) (list-ref (list-ref board 1) 1) (list-ref (list-ref board 2) 0))))

    (or
     (ormap check-line rows)
     (ormap check-line cols)
     (ormap check-line diags)))

  (cond
    [(not (or (equal? (- x-count o-count) 0) (equal? (- x-count o-count) 1))) #f]
    [else
     (define winner (get-winner))
     (cond
       [(not winner) #t]
       [(equal? winner #\X) (and (equal? (- x-count o-count) 1) (not (equal? (get-winner) #\O)))]
       [(equal? winner #\O) (and (equal? (- x-count o-count) 0) (not (equal? (get-winner) #\X)))]
       [else #f])]))