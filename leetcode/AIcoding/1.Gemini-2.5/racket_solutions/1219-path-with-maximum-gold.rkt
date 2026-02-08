(define (get-maximum-gold grid)
  (define rows (length grid))
  (define cols (length (car grid))) ; Assumes grid is non-empty and rectangular

  (define (get-gold r c)
    (list-ref (list-ref grid r) c))

  (define (is-valid r c)
    (and (>= r 0) (< r rows) (>= c 0) (< c cols)))

  (define max-gold 0)

  ; dfs returns the maximum gold collected starting from (r, c)
  ; and continuing the path, given the current visited-grid state.
  (define (dfs r c visited-grid)
    (cond
      ((or (not (is-valid r c))
           (= (get-gold r c) 0)
           (vector-ref (vector-ref visited-grid r) c))
       0) ; Base case: invalid coordinates, no gold, or already visited. This branch contributes 0 to the path.
      (else
       (let* ((current-cell-gold (get-gold r c)))
         (vector-set! (vector-ref visited-grid r) c #t) ; Mark current cell as visited

         (let ((max-from-neighbors 0))
           ; Explore all four adjacent directions
           (set! max-from-neighbors (max max-from-neighbors (dfs (+ r 1) c visited-grid))) ; Down
           (set! max-from-neighbors (max max-from-neighbors (dfs (- r 1) c visited-grid))) ; Up
           (set! max-from-neighbors (max max-from-neighbors (dfs r (+ c 1) visited-grid))) ; Right
           (set! max-from-neighbors (max max-from-neighbors (dfs r (- c 1) visited-grid))) ; Left

           (vector-set! (vector-ref visited-grid r) c #f) ; Backtrack: unmark current cell as visited for other paths

           (+ current-cell-gold max-from-neighbors)))))) ; Return current gold + max gold from any valid neighbor path
    )

  ; Iterate through each cell as a potential starting point
  (for* ((r (in-range rows))
         (c (in-range cols)))
    (when (> (get-gold r c) 0) ; Only start DFS from cells with gold
      ; For each starting point, a fresh visited-grid is needed
      (let ((visited-grid (make-vector rows)))
        (for ((i (in-range rows)))
          (vector-set! visited-grid i (make-vector cols #f))) ; Initialize all cells as not visited

        ; Update the global maximum gold found
        (set! max-gold (max max-gold (dfs r c visited-grid))))))

  max-gold)