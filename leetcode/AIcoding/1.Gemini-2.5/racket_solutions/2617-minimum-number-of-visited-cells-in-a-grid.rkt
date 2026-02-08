#lang racket

(require data/queue)

(define (minimum-visited-cells grid)
  (define m (vector-length grid))
  (define n (vector-length (vector-ref grid 0)))

  ; dist[r][c] stores the minimum number of cells visited to reach (r, c).
  ; #f indicates unvisited (infinity).
  (define dist (make-vector m #f))
  (for ([i (in-range m)])
    (vector-set! dist i (make-vector n #f)))

  ; q is the BFS queue, storing (row col) as lists.
  (define q (make-queue))

  ; next-col-ptr[r] stores the smallest column index k in row r
  ; such that (r, k) has not yet been processed by a horizontal move from a cell (r, c') where c' < k.
  ; This optimizes the range updates by skipping already processed cells.
  (define next-col-ptr (make-vector m 1)) ; Initialize to 1, as column 0 is handled by (0,0) start.

  ; Similarly for next-row-ptr[c].
  (define next-row-ptr (make-vector n 1)) ; Initialize to 1, as row 0 is handled by (0,0) start.

  ; Initialize starting cell (0,0)
  (vector-set! (vector-ref dist 0) 0 1)
  (enqueue! q (list 0 0))

  (while (not (queue-empty? q))
    (define current-pos (dequeue! q))
    (define r (first current-pos))
    (define c (second current-pos))
    (define current-dist (vector-ref (vector-ref dist r) c))
    (define cell-val (vector-ref (vector-ref grid r) c))

    ; --- Process horizontal moves ---
    ; Cells (r, k) can be reached where c < k <= c + cell-val.
    ; We also need to ensure k is within grid bounds [0, n-1].
    ; The loop starts from max(c+1, next-col-ptr[r]) to avoid re-processing cells
    ; that were already visited or skipped by previous horizontal moves in the same row.
    (define start-k-col (max (+ c 1) (vector-ref next-col-ptr r)))
    (define limit-k-col (min (- n 1) (+ c cell-val)))

    (let loop-col ([k start-k-col])
      (when (<= k limit-k-col)
        ; If (r, k) has not been visited yet (dist[r][k] is #f)
        (when (not (vector-ref (vector-ref dist r) k))
          (vector-set! (vector-ref dist r) k (+ current-dist 1))
          (enqueue! q (list r k)))
        ; Advance the pointer for row r to the next column to consider.
        ; This ensures that each cell (r, k) is enqueued at most once.
        (vector-set! next-col-ptr r (+ k 1))
        (loop-col (+ k 1))))

    ; --- Process vertical moves ---
    ; Cells (k, c) can be reached where r < k <= r + cell-val.
    ; We also need to ensure k is within grid bounds [0, m-1].
    ; Similar logic to horizontal moves, using next-row-ptr.
    (define start-k-row (max (+ r 1) (vector-ref next-row-ptr c)))
    (define limit-k-row (min (- m 1) (+ r cell-val)))

    (let loop-row ([k start-k-row])
      (when (<= k limit-k-row)
        ; If (k, c) has not been visited yet (dist[k][c] is #f)
        (when (not (vector-ref (vector-ref dist k) c))
          (vector-set! (vector-ref dist k) c (+ current-dist 1))
          (enqueue! q (list k c)))
        ; Advance the pointer for column c.
        (vector-set! next-row-ptr c (+ k 1))
        (loop-row (+ k 1))))
    )

  ; After BFS, check the distance to the target cell (m-1, n-1).
  (define result (vector-ref (vector-ref dist (- m 1)) (- n 1)))
  (if result
      result ; If reachable, return the distance.
      -1)    ; If not reachable (#f), return -1.
  )