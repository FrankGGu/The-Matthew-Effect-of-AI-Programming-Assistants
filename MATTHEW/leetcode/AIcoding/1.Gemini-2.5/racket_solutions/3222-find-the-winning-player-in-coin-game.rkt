(define (solve x y)
  ;; dp[i][j] will be #t if the current player can win from state (i, j), #f otherwise.
  ;; Initialize all states as losing states (#f).
  ;; We iterate from small i and j to larger ones, so when dp[i][j] is computed,
  ;; all necessary previous states (i-1, j-1), (i-2, j), (i, j-2) are already computed.
  (define dp (build-vector (+ x 1) (lambda (i) (build-vector (+ y 1) (lambda (j) #f)))))

  (for* ((i (in-range (+ x 1)))
         (j (in-range (+ y 1))))
    ;; A state (i, j) is a winning state if there exists at least one valid move
    ;; to a state (i', j') that is a losing state for the opponent (i.e., dp[i'][j'] is #f).

    ;; Try move 1: Take one coin of type A and one coin of type B
    (when (and (>= i 1) (>= j 1))
      (when (not (vector-ref (vector-ref dp (- i 1)) (- j 1)))
        (vector-set! (vector-ref dp i) j #t)))

    ;; Try move 2: Take two coins of type A
    ;; Only check if the current state is not already determined to be winning.
    (when (and (not (vector-ref (vector-ref dp i) j))
               (>= i 2))
      (when (not (vector-ref (vector-ref dp (- i 2)) j))
        (vector-set! (vector-ref dp i) j #t)))

    ;; Try move 3: Take two coins of type B
    ;; Only check if the current state is not already determined to be winning.
    (when (and (not (vector-ref (vector-ref dp i) j))
               (>= j 2))
      (when (not (vector-ref (vector-ref dp i) (- j 2)))
        (vector-set! (vector-ref dp i) j #t))))

  ;; After filling the DP table, check the initial state (x, y).
  (if (vector-ref (vector-ref dp x) y)
      "Alice"
      "Bob"))