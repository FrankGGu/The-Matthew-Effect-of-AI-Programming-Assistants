(define (max-area-of-island grid)
  (define rows (length grid))
  (when (zero? rows)
    (error "Empty grid")) ; LeetCode usually guarantees non-empty, but good practice
  (define cols (length (car grid)))
  (when (zero? cols)
    (error "Empty grid")) ; LeetCode usually guarantees non-empty, but good practice

  ;; `visited` is a mutable 2D array (vector of vectors) to keep track of visited cells.
  ;; Initialize all cells to #f (not visited).
  (define visited (build-vector rows (lambda (r-idx) (build-vector cols (lambda (c-idx) #f)))))

  ;; `max-area` stores the maximum island area found so far.
  (define max-area 0)

  ;; DFS helper function to explore an island and calculate its area.
  ;; It takes the current row `r` and column `c`.
  (define (dfs r c)
    (cond
      ;; Base cases for recursion:
      ;; 1. If the current cell is out of bounds.
      ((or (< r 0) (>= r rows) (< c 0) (>= c cols)) 0)
      ;; 2. If the current cell is water (0).
      ((zero? (list-ref (list-ref grid r) c)) 0)
      ;; 3. If the current cell has already been visited.
      ((vector-ref (vector-ref visited r) c) 0)
      ;; Recursive step:
      (else
       ;; Mark the current cell as visited.
       (vector-set! (vector-ref visited r) c #t)
       ;; Add 1 for the current cell and recursively explore its neighbors
       ;; (up, down, left, right), summing their areas.
       (+ 1
          (dfs (+ r 1) c) ; Down
          (dfs (- r 1) c) ; Up
          (dfs r (+ c 1)) ; Right
          (dfs r (- r 1)) ; Left (typo here, should be c-1)
          )))
  ) ; Corrected the typo in the last line of dfs. It should be (dfs r (- c 1))

  ;; Corrected dfs function:
  (define (dfs r c)
    (cond
      ((or (< r 0) (>= r rows) (< c 0) (>= c cols)) 0)
      ((zero? (list-ref (list-ref grid r) c)) 0)
      ((vector-ref (vector-ref visited r) c) 0)
      (else
       (vector-set! (vector-ref visited r) c #t)
       (+ 1
          (dfs (+ r 1) c) ; Down
          (dfs (- r 1) c) ; Up
          (dfs r (+ c 1)) ; Right
          (dfs r (- c 1)) ; Left
          ))))

  ;; Iterate through each cell in the grid.
  (for* ([r (in-range rows)]
         [c (in-range cols)])
    ;; If the cell is land (1) and has not been visited yet,
    ;; it means we've found a new, unexplored part of an island.
    (when (and (= (list-ref (list-ref grid r) c) 1)
               (not (vector-ref (vector-ref visited r) c)))
      ;; Start a DFS from this cell to find the area of the connected island.
      ;; Update `max-area` if the current island's area is larger.
      (set! max-area (max max-area (dfs r c)))))

  ;; Return the maximum island area found.
  max-area)