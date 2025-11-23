(define (update-board board click)
  (define (get-neighbors i j)
    (define (valid-index? i j)
      (and (>= i 0) (< i (vector-length board))
           (>= j 0) (< j (vector-length (vector-ref board 0)))))
    (filter (lambda (p) (apply valid-index? p))
            (list (list (- i 1) (- j 1)) (list (- i 1) j) (list (- i 1) (+ j 1))
                  (list i (- j 1))                     (list i (+ j 1))
                  (list (+ i 1) (- j 1)) (list (+ i 1) j) (list (+ i 1) (+ j 1)))))

  (define (count-adjacent-mines i j)
    (length (filter (lambda (p) (char=? (vector-ref (vector-ref board (car p)) (cadr p)) #\M))
                    (get-neighbors i j))))

  (define (reveal i j)
    (cond
      [(not (char=? (vector-ref (vector-ref board i) j) #\E))
       #f]
      [else
       (let ([mines (count-adjacent-mines i j)])
         (cond
           [(= mines 0)
            (vector-set! (vector-ref board i) j #\B)
            (for ([neighbor (in-list (get-neighbors i j))])
              (reveal (car neighbor) (cadr neighbor)))]
           [else
            (vector-set! (vector-ref board i) j (integer->char (+ mines (char->integer #\0))))]))]))

  (define (solve i j)
    (cond
      [(char=? (vector-ref (vector-ref board i) j) #\M)
       (vector-set! (vector-ref board i) j #\X)]
      [else
       (reveal i j)]))

  (solve (car click) (cadr click))
  board)