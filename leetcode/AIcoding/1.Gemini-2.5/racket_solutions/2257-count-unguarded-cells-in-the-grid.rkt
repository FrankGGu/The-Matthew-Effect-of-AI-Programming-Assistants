#lang racket

(define (count-unguarded-cells grid)
  (define rows (length grid))
  (define cols (length (car grid))) ; Assuming grid is not empty

  ; Convert input grid (list of lists) to a vector of vectors for O(1) access
  (define grid-vec (make-vector rows))
  (for ([r (in-range rows)])
    (vector-set! grid-vec r (list->vector (list-ref grid r))))

  ; Create a 2D vector for guarded status, initialized to #f
  (define guarded-map (make-vector rows))
  (for ([r (in-range rows)])
    (vector-set! guarded-map r (make-vector cols #f)))

  ; Iterate through the grid to find guards and mark guarded cells
  (for ([r (in-range rows)])
    (for ([c (in-range cols)])
      (when (= (vector-ref (vector-ref grid-vec r) c) 2) ; If it's a guard
        ; Mark cells to the right
        (for ([kc (in-range (+ c 1) cols)])
          (when (= (vector-ref (vector-ref grid-vec r) kc) 1) ; If it's a wall
            (break)) ; Stop in this direction
          (vector-set! (vector-ref guarded-map r) kc #t))

        ; Mark cells to the left
        (for ([kc (in-range (- c 1) -1 -1)]) ; From c-1 down to 0
          (when (= (vector-ref (vector-ref grid-vec r) kc) 1)
            (break))
          (vector-set! (vector-ref guarded-map r) kc #t))

        ; Mark cells downwards
        (for ([kr (in-range (+ r 1) rows)])
          (when (= (vector-ref (vector-ref grid-vec kr) c) 1)
            (break))
          (vector-set! (vector-ref guarded-map kr) c #t))

        ; Mark cells upwards
        (for ([kr (in-range (- r 1) -1 -1)]) ; From r-1 down to 0
          (when (= (vector-ref (vector-ref grid-vec kr) c) 1)
            (break))
          (vector-set! (vector-ref guarded-map kr) c #t)))))

  ; Count unguarded empty cells
  (define unguarded-count 0)
  (for ([r (in-range rows)])
    (for ([c (in-range cols)])
      (when (and (= (vector-ref (vector-ref grid-vec r) c) 0) ; If it's an empty cell
                 (not (vector-ref (vector-ref guarded-map r) c))) ; And it's not guarded
        (set! unguarded-count (+ unguarded-count 1)))))

  unguarded-count)