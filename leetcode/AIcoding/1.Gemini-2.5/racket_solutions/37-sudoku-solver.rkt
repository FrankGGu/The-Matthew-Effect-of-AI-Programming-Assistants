#lang racket

(define (solve-sudoku board)
  (define n 9) ; Sudoku board size is 9x9

  ;; Helper function to check if placing 'char' at (r, c) is valid
  ;; Assumes board[r][c] is currently '.'
  (define (is-valid? r c char)
    ;; Check row
    (for ([j (in-range n)])
      (when (char=? (vector-ref (vector-ref board r) j) char)
        (return-from is-valid? #f)))

    ;; Check column
    (for ([i (in-range n)])
      (when (char=? (vector-ref (vector-ref board i) c) char)
        (return-from is-valid? #f)))

    ;; Check 3x3 box
    (define box-start-row (* 3 (quotient r 3)))
    (define box-start-col (* 3 (quotient c 3)))
    (for ([i (in-range box-start-row (+ box-start-row 3))])
      (for ([j (in-range box-start-col (+ box-start-col 3))])
        (when (char=? (vector-ref (vector-ref board i) j) char)
          (return-from is-valid? #f))))
    #t) ; If no conflicts, it's valid

  ;; Main backtracking solver function
  (define (solve)
    (for* ([r (in-range n)]
           [c (in-range n)])
      (when (char=? (vector-ref (vector-ref board r) c) #\.)
        ;; Found an empty cell, try placing digits '1' through '9'
        (for ([digit-val (in-range 1 10)]) ; Integers 1 to 9
          (define digit-char (integer->char (+ (char->integer #\0) digit-val)))
          (when (is-valid? r c digit-char)
            (vector-set! (vector-ref board r) c digit-char) ; Place digit
            (when (solve) ; Recurse
              (return-from solve #t)) ; If solved, propagate true
            (vector-set! (vector-ref board r) c #\.))) ; Backtrack: reset cell
        (return-from solve #f))) ; If no digit worked for this cell, this path is a dead end
    #t) ; If no empty cells found after iterating all, board is solved

  ;; Start the solving process
  (solve)
  )