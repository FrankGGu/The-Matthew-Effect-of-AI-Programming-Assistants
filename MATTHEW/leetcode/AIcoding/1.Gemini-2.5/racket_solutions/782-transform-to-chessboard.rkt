#lang racket

(define (transform-to-chessboard board)
  (define n (length board))

  ;; Helper to get an element at (r, c)
  (define (get-elem r c)
    (list-ref (list-ref board r) c))

  (with-handlers
      ([exn:fail? (lambda (exn) -1)]) ; Catch errors and return -1

    ;; --- Step 1: Check the chessboard structure ---
    ;; For a board to be transformable into a chessboard,
    ;; it must satisfy board[i][j] ^ board[i][0] == board[0][j] ^ board[0][0]
    ;; for all i, j. This ensures that every row is either identical to board[0]
    ;; or its inverse, and similarly for columns.
    (for* ([i (range n)]
           [j (range n)])
      (unless (= (xor (get-elem i j) (get-elem i 0))
                 (xor (get-elem 0 j) (get-elem 0 0)))
        (error 'transform-to-chessboard #f))) ; Indicate failure by throwing an error

    ;; --- Step 2: Calculate mismatches for rows and columns ---
    ;; We count how many elements in the first row (board[0]) and first column
    ;; (board[i][0]) differ from the ideal '0101...' alternating pattern.
    (define row0-mismatch-with-0101 0)
    (define col0-mismatch-with-0101 0)

    (for ([j (range n)])
      (when (!= (get-elem 0 j) (modulo j 2))
        (set! row0-mismatch-with-0101 (+ row0-mismatch-with-0101 1))))

    (for ([i (range n)])
      (when (!= (get-elem i 0) (modulo i 2))
        (set! col0-mismatch-with-0101 (+ col0-mismatch-with-0101 1))))

    ;; --- Step 3: Calculate minimum swaps needed ---
    ;; This function determines the minimum swaps to make a single row/column
    ;; (represented by its mismatch count 'diff0') alternating.
    ;; 'diff0' is the number of elements that differ from '0101...'.
    ;; 'diff1' is the number of elements that differ from '1010...'.
    (define (calculate-swaps diff0 n)
      (define diff1 (- n diff0))
      (cond
        [(even? n) ; If N is even, both diff0 and diff1 must be even.
         (if (even? diff0)
             (min (/ diff0 2) (/ diff1 2))
             (error 'calculate-swaps #f))] ; If diff0 is odd, it's impossible.
        [else ; If N is odd, one of diff0 or diff1 must be even, the other odd.
         (if (even? diff0)
             (/ diff0 2)
             (/ diff1 2))])) ; We pick the pattern that requires an even number of mismatches.

    (define row-swaps (calculate-swaps row0-mismatch-with-0101 n))
    (define col-swaps (calculate-swaps col0-mismatch-with-0101 n))

    (+ row-swaps col-swaps)))