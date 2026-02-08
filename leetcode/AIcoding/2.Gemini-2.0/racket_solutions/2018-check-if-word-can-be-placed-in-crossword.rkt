(define (place-word-in-crossword board word)
  (define rows (length board))
  (define cols (length (car board)))
  (define word-len (string-length word))

  (define (check-horizontal row col direction)
    (define (valid-index? index)
      (and (>= index 0) (< index cols)))

    (define (check-char index char)
      (cond
        [(not (valid-index? index)) #f]
        [(equal? (list-ref (list-ref board row) index) #\ ) #t]
        [(equal? (list-ref (list-ref board row) index) char) #t]
        [else #f]))

    (cond
      [(not (valid-index? col)) #f]
      [(not (valid-index? (+ col (* direction (- word-len 1))))) #f]
      [(and (or (= col 0) (not (equal? (list-ref (list-ref board row) (- col direction)) #\ )))
            (or (= (+ col (* direction (- word-len 1)) direction) cols) (not (equal? (list-ref (list-ref board row) (+ col (* direction (- word-len 1)) direction)) #\ ))))
       (let loop ([i 0])
         (cond
           [(= i word-len) #t]
           [else
            (if (check-char (+ col (* direction i)) (string-ref word i))
                (loop (+ i 1))
                #f)])) ]
      [else #f]))

  (define (check-vertical row col direction)
    (define (valid-index? index)
      (and (>= index 0) (< index rows)))

    (define (check-char index char)
      (cond
        [(not (valid-index? index)) #f]
        [(equal? (list-ref (list-ref board index) col) #\ ) #t]
        [(equal? (list-ref (list-ref board index) col) char) #t]
        [else #f]))

    (cond
      [(not (valid-index? row)) #f]
      [(not (valid-index? (+ row (* direction (- word-len 1))))) #f]
      [(and (or (= row 0) (not (equal? (list-ref (list-ref board (- row direction)) col) #\ )))
            (or (= (+ row (* direction (- word-len 1)) direction) rows) (not (equal? (list-ref (list-ref board (+ row (* direction (- word-len 1)) direction)) col) #\ ))))
       (let loop ([i 0])
         (cond
           [(= i word-len) #t]
           [else
            (if (check-char (+ row (* direction i)) (string-ref word i))
                (loop (+ i 1))
                #f)])) ]
      [else #f]))

  (let loop-rows ([r 0])
    (cond
      [(= r rows) #f]
      [else
       (let loop-cols ([c 0])
         (cond
           [(= c cols) (loop-rows (+ r 1))]
           [else
            (if (equal? (list-ref (list-ref board r) c) #\#)
                (begin
                  (if (check-horizontal r c 1) (return #t))
                  (if (check-vertical r c 1) (return #t))
                  (if (check-horizontal r c -1) (return #t))
                  (if (check-vertical r c -1) (return #t)))
                #f)
            (loop-cols (+ c 1))]))]))
  #f)