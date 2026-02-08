(define (find-all-groups-of-farmland grid)
  (define rows (vector-length grid))
  (define cols (vector-length (vector-ref grid 0)))
  (define result '())

  ;; Mutable variables to track the maximum row and column found in the current DFS traversal
  (define max-r-val 0)
  (define max-c-val 0)

  ;; DFS function to explore a connected component and find its bottom-right corner
  (define (dfs r c)
    ;; Mark the current cell as visited by changing its value to 0
    (vector-set! (vector-ref grid r) c 0)

    ;; Update the maximum row and column found so far in this component
    (set! max-r-val (max max-r-val r))
    (set! max-c-val (max max-c-val c))

    ;; Define a helper to explore a neighbor
    (define (explore nr nc)
      (when (and (>= nr 0) (< nr rows) ; Check row bounds
                 (>= nc 0) (< nc cols) ; Check column bounds
                 (= (vector-ref (vector-ref grid nr) nc) 1)) ; Check if it's farmland
        (dfs nr nc))) ; Recursively call DFS for the neighbor

    ;; Explore all four neighbors (down, up, right, left)
    (explore (+ r 1) c) ; Down
    (explore (- r 1) c) ; Up
    (explore r (+ c 1)) ; Right
    (explore r (- c 1)) ; Left
    )

  ;; Iterate through each cell of the grid
  (for* ([r (in-range rows)]
         [c (in-range cols)])
    ;; If a cell contains '1', it's the top-left corner of a new farmland group
    (when (= (vector-ref (vector-ref grid r) c) 1)
      ;; Initialize max-r-val and max-c-val for this new group
      ;; The top-left cell itself is the initial max for this group
      (set! max-r-val r)
      (set! max-c-val c)

      ;; Start DFS from this top-left corner
      (dfs r c)

      ;; After DFS completes, max-r-val and max-c-val hold the bottom-right corner
      ;; Add the found group's coordinates to the result list
      (set! result (cons (list r c max-r-val max-c-val) result))))

  ;; The result list was built by consing, so it's in reverse order. Reverse it back.
  (reverse result))