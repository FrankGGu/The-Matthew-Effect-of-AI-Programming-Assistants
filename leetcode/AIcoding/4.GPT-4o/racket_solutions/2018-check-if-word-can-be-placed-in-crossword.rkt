(define (place-word-in-crossword board word)
  (define (can-place? row col dr dc)
    (let loop ((r row) (c col) (i 0))
      (cond
        [(or (< r 0) (>= r (length board)) (< c 0) (>= (length (list-ref board r)) (length word))) #f]
        [(= i (length word)) #t]
        [(char=? (list-ref (list-ref board r) c) (string-ref word i))
         (loop (+ r dr) (+ c dc) (+ i 1))]
        [(char=? (list-ref (list-ref board r) c) #\space)
         (loop (+ r dr) (+ c dc) (+ i 1))]
        [else #f])))

  (define (word-can-fit? row col)
    (or (can-place? row col 0 1) (can-place? row col 1 0)))

  (define (check-word-fit)
    (for/fold ([result #t]) ([r (in-range (length board))])
      (if (or (not result) (not (word-can-fit? r 0)))
          #f
          result)))

  (and (check-word-fit)
       (for/fold ([result #t]) ([c (in-range (length (car board)))])
         (if (or (not result) (not (word-can-fit? 0 c)))
             #f
             result))))

  (check-word-fit))