(define (valid-tic-tac-toe-state board)

  (define (count-pieces board)
    (let loop ((rows board) (x-count 0) (o-count 0))
      (if (null? rows)
          (list x-count o-count)
          (let* ((row-str (car rows))
                 (current-x-in-row (for/sum ((c (in-string row-str))) (if (char=? c #\X) 1 0)))
                 (current-o-in-row (for/sum ((c (in-string row-str))) (if (char=? c #\O) 1 0))))
            (loop (cdr rows) (+ x-count current-x-in-row) (+ o-count current-o-in-row))))))

  (define (check-win player board)
    (let* ((p-char (string-ref (symbol->string player) 0))
           (b0 (list-ref board 0))
           (b1 (list-ref board 1))
           (b2 (list-ref board 2)))
      (or
       ;; Rows
       (and (char=? (string-ref b0 0) p-char) (char=? (string-ref b0 1) p-char) (char=? (string-ref b0 2) p-char))
       (and (char=? (string-ref b1 0) p-char) (char=? (string-ref b1 1) p-char) (char=? (string-ref b1 2) p-char))
       (and (char=? (string-ref b2 0) p-char) (char=? (string-ref b2 1) p-char) (char=? (string-ref b2 2) p-char))
       ;; Columns
       (and (char=? (string-ref b0 0) p-char) (char=? (string-ref b1 0) p-char) (char=? (string-ref b2 0) p-char))
       (and (char=? (string-ref b0 1) p-char) (char=? (string-ref b1 1) p-char) (char=? (string-ref b2 1) p-char))
       (and (char=? (string-ref b0 2) p-char) (char=? (string-ref b1 2) p-char) (char=? (string-ref b2 2) p-char))
       ;; Diagonals
       (and (char=? (string-ref b0 0) p-char) (char=? (string-ref b1 1) p-char) (char=? (string-ref b2 2) p-char))
       (and (char=? (string-ref b0 2) p-char) (char=? (string-ref b1 1) p-char) (char=? (string-ref b2 0) p-char)))))

  (let* ((counts (count-pieces board))
         (x-count (list-ref counts 0))
         (o-count (list-ref counts 1))
         (x-wins (check-win 'X board))
         (o-wins (check-win 'O board)))

    (and
     ;; Rule 1: Count of X and O
     (or (= x-count o-count) (= x-count (+ o-count 1)))

     ;; Rule 2: If X wins, X must have played last
     (if x-wins
         (= x-count (+ o-count 1))
         #t)

     ;; Rule 3: If O wins, O must have played last
     (if o-wins
         (= x-count o-count)
         #t)

     ;; Rule 4: Both cannot win
     (not (and x-wins o-wins)))))