(define (updateBoard board click)
  (let* ((rows (length board))
         (cols (length (car board)))
         (r (car click))
         (c (cadr click)))

    ;; Helper to safely get char, returns #\N for out of bounds
    (define (get-char brd row col)
      (if (or (< row 0) (>= row rows) (< col 0) (>= col cols))
          #\N ; Sentinel for out of bounds
          (list-ref (list-ref brd row) col)))

    ;; Helper to create a new board with char updated at (row, col)
    (define (set-char brd row col new-char)
      (list-set brd row (list-set (list-ref brd row) col new-char)))

    ;; Helper to count adjacent mines for a given cell (row, col)
    (define (count-adjacent-mines brd row col)
      (let ((directions '((-1 -1) (-1 0) (-1 1)
                          (0 -1)          (0 1)
                          (1 -1)  (1 0)   (1 1))))
        (apply + (map (lambda (dir)
                        (let* ((dr (car dir))
                               (dc (cadr dir))
                               (nr (+ row dr))
                               (nc (+ col dc)))
                          (if (char=? (get-char brd nr nc) #\M) 1 0)))
                      directions))))

    ;; Recursive function to reveal cells
    (define (reveal brd row col)
      (let ((current-char (get-char brd row col)))
        (cond
          ;; Base cases: out of bounds or already revealed/mine
          ((not (char=? current-char #\E))
           brd)
          (else
           (let ((mine-count (count-adjacent-mines brd row col)))
             (if (> mine-count 0)
                 ;; If mines > 0, update current cell to digit and stop recursion
                 (set-char brd row col (integer->char (+ (char->integer #\0) mine-count)))
                 ;; If mines == 0, update to 'B' and recurse on neighbors
                 (let* ((board-with-B (set-char brd row col #\B))
                        (neighbors '((-1 -1) (-1 0) (-1 1)
                                     (0 -1)          (0 1)
                                     (1 -1)  (1 0)   (1 1))))
                   ;; Fold over neighbors, passing the updated board state
                   (foldl (lambda (dir current-board-state)
                            (let* ((dr (car dir))
                                   (dc (cadr dir))
                                   (nr (+ row dr))
                                   (nc (+ col dc)))
                              (reveal current-board-state nr nc)))
                          board-with-B
                          neighbors))))))))

    ;; Main logic for the initial click
    (let ((clicked-char (get-char board r c)))
      (cond
        ((char=? clicked-char #\M)
         ;; If a mine is clicked, change to 'X' and game over
         (set-char board r c #\X))
        ((char=? clicked-char #\E)
         ;; If an empty square is clicked, start revealing
         (reveal board r c))
        (else
         ;; If already revealed (digit, 'B', or 'X'), no change needed
         board)))))