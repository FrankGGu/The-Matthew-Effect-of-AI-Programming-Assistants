(define (unique-paths-iii grid)
  (define rows (vector-length grid))
  (define cols (vector-length (vector-ref grid 0)))

  (define start-r 0)
  (define start-c 0)
  (define total-squares-to-visit 0) ; Counts 0s, 1s, and 2s

  ;; Find start coordinates and count all non-obstacle squares
  (for* ([r (in-range rows)]
         [c (in-range cols)])
    (case (vector-ref (vector-ref grid r) c)
      [1 (set! start-r r)
         (set! start-c c)
         (set! total-squares-to-visit (+ total-squares-to-visit 1))]
      [0 (set! total-squares-to-visit (+ total-squares-to-visit 1))]
      [2 (set! total-squares-to-visit (+ total-squares-to-visit 1))]
      [-1 #f] ; Obstacle, do nothing
      ))

  (define (dfs r c visited-count)
    ;; Base cases: out of bounds, obstacle, or already visited
    (when (or (< r 0) (>= r rows) (< c 0) (>= c cols)
              (= (vector-ref (vector-ref grid r) c) -1) ; Obstacle
              (= (vector-ref (vector-ref grid r) c) -2)) ; Already visited
      (error 'dfs "Should not reach here if called correctly from valid neighbors, or it's an obstacle/visited cell, returning 0.")) ; This error indicates a logic flaw if triggered.

    (if (= (vector-ref (vector-ref grid r) c) 2) ; Reached the end square
        ;; Check if all non-obstacle squares have been visited
        (if (= visited-count total-squares-to-visit) 1 0)
        ;; Current square is 0 (empty) or 1 (start)
        (let ([original-val (vector-ref (vector-ref grid r) c)])
          (vector-set! (vector-ref grid r) c -2) ; Mark current square as visited

          ;; Explore neighbors
          (let ([paths (+ (if (and (>= (+ r 1) 0) (< (+ r 1) rows) (not (= (vector-ref (vector-ref grid (+ r 1)) c) -1)) (not (= (vector-ref (vector-ref grid (+ r 1)) c) -2))) (dfs (+ r 1) c (+ visited-count 1)) 0)
                          (if (and (>= (- r 1) 0) (< (- r 1) rows) (not (= (vector-ref (vector-ref grid (- r 1)) c) -1)) (not (= (vector-ref (vector-ref grid (- r 1)) c) -2))) (dfs (- r 1) c (+ visited-count 1)) 0)
                          (if (and (>= c 0) (< (+ c 1) cols) (not (= (vector-ref (vector-ref grid r) (+ c 1)) -1)) (not (= (vector-ref (vector-ref grid r) (+ c 1)) -2))) (dfs r (+ c 1) (+ visited-count 1)) 0)
                          (if (and (>= c 0) (< (- c 1) cols) (not (= (vector-ref (vector-ref grid r) (- c 1)) -1)) (not (= (vector-ref (vector-ref grid r) (- c 1)) -2))) (dfs r (- c 1) (+ visited-count 1)) 0))])

            (vector-set! (vector-ref grid r) c original-val) ; Backtrack: unmark the current square
            paths))))

  ;; Initial call to DFS from the start square
  ;; The start square itself counts as the first visited square, so visited-count starts at 1.
  (dfs start-r start-c 1))