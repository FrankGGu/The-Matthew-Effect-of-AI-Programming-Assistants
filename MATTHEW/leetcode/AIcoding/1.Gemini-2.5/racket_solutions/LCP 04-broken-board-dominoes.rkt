(require racket/vector)

(define (broken-board-dominoes board)
  (define R 3) ; Number of rows
  (define N (length (car board))) ; Number of columns

  ; dp[col][mask] stores the maximum dominoes placed up to col-1,
  ; where mask describes the state of column 'col'.
  ; (logbit? r mask) is 1 if cell (r, col) is covered by a horizontal domino from (r, col-1).
  ; (logbit? r mask) is 0 if cell (r, col) is available to be covered.
  ; Initialize dp table with -1 (representing uncomputed or unreachable states).
  ; (vector-ref (vector-ref dp col) mask)
  (define dp (make-vector (add1 N) (make-vector (expt 2 R) -1)))

  ; Base case: 0 columns processed, column 0 has no cells covered from previous.
  ; This state is reachable with 0 dominoes.
  (vector-set! (vector-ref dp 0) 0 0)

  ; Helper function to generate next states for column `col`
  ; r: current row index (0 to R-1) being considered in column `col`
  ; current-col-mask: mask for column `col` that indicates which cells are already covered
  ;                   by horizontal dominoes from `col-1` OR by vertical dominoes placed within this `generate-next-states` call chain.
  ; next-col-mask: mask being built for column `col+1`. Indicates cells in `col+1` covered by horizontal dominoes from `col`.
  ; dominoes-in-col: number of dominoes placed *within* column `col` during this `generate-next-states` call chain.
  ; prev-val: dp[col][prev-mask] value (total dominoes up to col-1).
  ; col: current column index being processed.
  (define (generate-next-states r current-col-mask next-col-mask dominoes-in-col prev-val col)
    (when (= r R) ; All rows processed for current column `col`
      (let* ([total-dominoes (+ prev-val dominoes-in-col)]
             [current-max (vector-ref (vector-ref dp (add1 col)) next-col-mask)])
        (when (> total-dominoes current-max)
          (vector-set! (vector-ref dp (add1 col)) next-col-mask total-dominoes)))
      (void))

    (unless (= r R) ; If not all rows processed
      (if (logbit? r current-col-mask) ; Cell (r, col) is already covered
          ; Move to the next row, no new dominoes placed here.
          (generate-next-states (add1 r) current-col-mask next-col-mask dominoes-in-col prev-val col)
          ; Cell (r, col) is not covered by current-col-mask.
          (if (not (list-ref (list-ref board r) col)) ; Cell (r, col) is broken and not covered
              ; This path is invalid. Cannot tile a broken cell that is not covered.
              ; Do nothing, effectively pruning this branch.
              (void)
              ; Cell (r, col) is available and not covered. It *must* be covered.
              (begin
                ; Option 1: Place a horizontal domino (r, col) to (r, col+1)
                ; Requires col+1 < N and board[r][col+1] is true.
                (when (and (< (add1 col) N)
                           (list-ref (list-ref board r) (add1 col)))
                  (generate-next-states (add1 r)
                                        current-col-mask
                                        (bitwise-ior next-col-mask (arithmetic-shift 1 r)) ; Mark (r, col+1) as covered
                                        (add1 dominoes-in-col)
                                        prev-val
                                        col))

                ; Option 2: Place a vertical domino (r, col) and (r+1, col)
                ; Requires r+1 < R, (r+1, col) is not covered by current-col-mask,
                ; and board[r+1][col] is true.
                (when (and (< (add1 r) R)
                           (not (logbit? (add1 r) current-col-mask))
                           (list-ref (list-ref board (add1 r)) col))
                  (generate-next-states (+ r 2) ; Skip r and r+1 as they are now covered
                                        (bitwise-ior current-col-mask (arithmetic-shift 1 (add1 r))) ; Mark (r+1, col) as covered for this step
                                        next-col-mask
                                        (add1 dominoes-in-col)
                                        prev-val
                                        col)))))))

  ; Iterate through columns from 0 to N-1
  (for ([col (in-range N)])
    ; Iterate through all possible previous masks (0 to 2^R - 1)
    (for ([prev-mask (in-range (expt 2 R))])
      (let ([prev-val (vector-ref (vector-ref dp col) prev-mask)])
        (unless (= prev-val -1) ; If this state (dp[col][prev-mask]) is reachable
          ; Before calling generate-next-states, ensure prev-mask is valid for the current column 'col'.
          ; A prev-mask is invalid if it implies covering a broken cell in column `col`.
          (let loop ([r 0] [valid-prev-mask? #t])
            (if (= r R)
                (when valid-prev-mask?
                  ; Start generating next states for column `col`
                  ; Initial call: r=0, current-col-mask is prev-mask, next-col-mask starts at 0, 0 dominoes in col.
                  (generate-next-states 0 prev-mask 0 0 prev-val col))
                (if (and (logbit? r prev-mask) (not (list-ref (list-ref board r) col)))
                    (loop R #f) ; Invalid prev-mask: a broken cell (r, col) is marked as covered by prev-mask. Prune this branch.
                    (loop (add1 r) valid-prev-mask?))))))))

  ; The final answer is the maximum value in dp[N][0].
  ; At the end of the board (column N), no cells in column N should be covered by
  ; horizontal dominoes from N-1. This means the mask for column N must be 0.
  (vector-ref (vector-ref dp N) 0))