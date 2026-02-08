(define (calculate-minimum-hp dungeon-list)
  (define m (length dungeon-list))
  (define n (length (car dungeon-list)))

  ;; Convert dungeon-list (list of lists) to a vector of vectors for efficient mutable access
  (define dungeon (build-vector m (lambda (i) (list->vector (list-ref dungeon-list i)))))

  ;; dp[i][j] stores the minimum health required *upon entering* cell (i, j)
  ;; to guarantee survival until the princess.
  (define dp (build-vector m (lambda (i) (build-vector n (lambda (j) 0)))))

  ;; Iterate backwards from the princess's cell (m-1, n-1) to (0, 0)
  (for* ([i (range (- m 1) -1 -1)]
         [j (range (- n 1) -1 -1)])
    (let* ([current-dungeon-val (vector-ref (vector-ref dungeon i) j)]
           [min-health-from-next-cell 0])

      (cond
        ;; Base case: Princess's cell (m-1, n-1)
        [(= i (- m 1))
         (cond
           [(= j (- n 1))
            ;; If there is no next cell, the knight needs at least 1 HP *after* passing through this cell.
            ;; Conceptually, the "minimum health needed from the next cell" is 1.
            (set! min-health-from-next-cell 1)]
           ;; Last row, but not last column: Knight can only move right
           [else
            (set! min-health-from-next-cell (vector-ref (vector-ref dp i) (+ j 1)))])]
        ;; Last column, but not last row: Knight can only move down
        [(= j (- n 1))
         (set! min-health-from-next-cell (vector-ref (vector-ref dp (+ i 1)) j))]
        ;; General case: Knight can move right or down. Choose the path that requires less health.
        [else
         (set! min-health-from-next-cell
               (min (vector-ref (vector-ref dp i) (+ j 1))
                    (vector-ref (vector-ref dp (+ i 1)) j)))]
        )

      ;; Calculate dp[i][j]:
      ;; If the knight enters (i,j) with H health, after passing through dungeon[i][j],
      ;; his health becomes H + dungeon[i][j]. This must be at least min-health-from-next-cell.
      ;; So, H >= min-health-from-next-cell - dungeon[i][j].
      ;; Also, H must always be at least 1.
      (let ([health-needed-before-current-cell (- min-health-from-next-cell current-dungeon-val)])
        (vector-set! (vector-ref dp i) j (max 1 health-needed-before-current-cell))
        )))

  ;; The result is the minimum health required upon entering the starting cell (0, 0)
  (vector-ref (vector-ref dp 0) 0))