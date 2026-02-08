(define (solve-sudoku board)
  (define (is-valid? board row col num)
    (and
     (not (ormap (lambda (c) (equal? c num)) (list-ref board row)))
     (not (ormap (lambda (r) (equal? (list-ref (list-ref board r) col) num)) (range 9)))
     (not (ormap (lambda (r)
                   (ormap (lambda (c)
                            (equal? (list-ref (list-ref board (+ (* (quotient row 3) 3) r)) (+ (* (quotient col 3) 3) c)) num))
                          (range 3)))
                 (range 3)))))

  (define (solve board)
    (define (find-empty board)
      (for*/first
       ([r (in-range 9)]
        [c (in-range 9)]
        #:when (equal? (list-ref (list-ref board r) c) #\.))
       (cons r c)))

    (let ([empty-pos (find-empty board)])
      (cond
        [(not empty-pos) #t]
        [else
         (let ([row (car empty-pos)]
               [col (cdr empty-pos)])
           (for/or ([num (in-range 1 10)])
             (let ([num-str (number->string num)])
               (if (is-valid? board row col num-str)
                   (begin
                     (list-set! (list-ref board row) col num-str)
                     (if (solve board)
                         #t
                         (begin
                           (list-set! (list-ref board row) col #\.)
                           #f)))
                   #f)))))])))

  (solve board)
  (void))