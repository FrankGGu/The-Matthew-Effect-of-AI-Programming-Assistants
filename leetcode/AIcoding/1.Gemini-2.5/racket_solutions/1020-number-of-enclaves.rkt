#lang racket

(define (num-enclaves grid)
  (define rows (length grid))
  (define cols (length (car grid))) ; Assumes grid is not empty and has non-empty rows

  ; Convert list of lists to vector of vectors for mutable access
  (define mutable-grid (make-vector rows))
  (for ([r (in-range rows)])
    (vector-set! mutable-grid r (list->vector (list-ref grid r))))

  (define (is-valid r c)
    (and (>= r 0) (< r rows) (>= c 0) (< c cols)))

  (define (dfs r c)
    (when (and (is-valid r c)
               (= (vector-ref (vector-ref mutable-grid r) c) 1))
      (vector-set! (vector-ref mutable-grid r) c 0) ; Mark as visited/border-connected
      (dfs (+ r 1) c)
      (dfs (- r 1) c)
      (dfs r (+ c 1))
      (dfs r (- c 1))))

  ; DFS from all border '1's
  ; Top and Bottom rows
  (for ([c (in-range cols)])
    (dfs 0 c)           ; Top border
    (dfs (- rows 1) c)) ; Bottom border

  ; Left and Right columns (excluding cells already covered by top/bottom rows)
  (for ([r (in-range rows)])
    (dfs r 0)           ; Left border
    (dfs r (- cols 1))) ; Right border

  ; Count remaining '1's
  (define count 0)
  (for ([r (in-range rows)])
    (for ([c (in-range cols)])
      (when (= (vector-ref (vector-ref mutable-grid r) c) 1)
        (set! count (+ count 1)))))
  count)