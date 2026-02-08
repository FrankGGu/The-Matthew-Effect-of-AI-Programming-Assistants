(define (solve-n-queens n)

  (define (build-board n queens-cols)
    ;; queens-cols is a list of column indices, where the index in the list
    ;; corresponds to the row number. E.g., (0 2 1 3) for N=4 means
    ;; (0,0), (1,2), (2,1), (3,3)
    (for/list ([q-col queens-cols])
      (list->string
       (for/list ([col (range n)])
         (if (= col q-col) #\Q #\.)))))

  (define (is-safe? current-row current-col placed-queens-cols)
    ;; placed-queens-cols is a list of column indices for queens placed in rows 0 to current-row-1.
    ;; We need to check if placing a queen at (current-row, current-col) conflicts
    ;; with any of the previously placed queens.
    (define (check-prev-queens r prev-queens-list)
      (cond
        [(null? prev-queens-list) #t] ; All previous queens checked, no conflict found
        [else
         (define prev-col (car prev-queens-list))
         (cond
           [(= prev-col current-col) #f] ; Same column
           [(= (abs (- prev-col current-col)) (abs (- r current-row))) #f] ; Same diagonal
           [else (check-prev-queens (+ 1 r) (cdr prev-queens-list))])]))

    (check-prev-queens 0 placed-queens-cols))

  (define (backtrack row current-queens-cols)
    ;; row: The current row we are trying to place a queen in.
    ;; current-queens-cols: List of column indices for queens placed in rows 0 to row-1.
    (if (= row n)
        ;; Base case: All N queens are placed successfully.
        (list (build-board n current-queens-cols))
        ;; Recursive step: Try placing a queen in each column of the current row.
        (apply append
               (for/list ([col (range n)])
                 (if (is-safe? row col current-queens-cols)
                     ;; If safe, place the queen and recurse for the next row.
                     (backtrack (+ 1 row) (append current-queens-cols (list col)))
                     ;; If not safe, this path yields no solutions.
                     '())))))

  (if (= n 0)
      '() ; Handle the edge case for n=0, though constraints say n >= 1.
      (backtrack 0 '())))