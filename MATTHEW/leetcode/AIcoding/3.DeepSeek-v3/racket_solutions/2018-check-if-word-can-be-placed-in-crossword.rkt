(define (place-word-in-crossword board word)
  (let ((m (length board))
        (n (string-length (list-ref board 0))))
    (define (check-row row col dir)
      (let loop ((i 0) (j col))
        (cond
          [(= i (string-length word))
           (or (>= j n) (char=? (string-ref (list-ref board row) j) #\#))]
          [(>= j n) #f]
          [(char=? (string-ref (list-ref board row) j) #\#) #f]
          [(or (char=? (string-ref (list-ref board row) j) #\ )
               (char=? (string-ref word i) (string-ref (list-ref board row) j)))
           (loop (+ i 1) (+ j dir)))]
          [else #f])))
    (define (check-col row col dir)
      (let loop ((i 0) (j row))
        (cond
          [(= i (string-length word))
           (or (>= j m) (char=? (string-ref (list-ref board j) col) #\#))]
          [(>= j m) #f]
          [(char=? (string-ref (list-ref board j) col) #\#) #f]
          [(or (char=? (string-ref (list-ref board j) col) #\ )
               (char=? (string-ref word i) (string-ref (list-ref board j) col)))
           (loop (+ i 1) (+ j dir)))]
          [else #f])))
    (or
     (for/or ([row (in-range m)])
       (for/or ([col (in-range (- n (string-length word) -1))])
         (or (check-row row col 1)
             (check-row row (+ col (string-length word) -1))))
     (for/or ([col (in-range n)])
       (for/or ([row (in-range (- m (string-length word) -1))])
         (or (check-col row col 1)
             (check-col (+ row (string-length word)) col -1)))))))