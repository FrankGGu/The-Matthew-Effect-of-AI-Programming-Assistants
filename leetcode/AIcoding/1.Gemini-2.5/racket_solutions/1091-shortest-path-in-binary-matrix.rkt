#lang racket

(require data/queue)

(define (shortest-path-binary-matrix grid)
  (define n (length grid))

  ;; Convert grid to vector of vectors for O(1) access
  (define grid-vec (make-vector n))
  (for ([i (in-range n)])
    (vector-set! grid-vec i (list->vector (list-ref grid i))))

  ;; Handle 1x1 grid explicitly
  (when (= n 1)
    (if (= (vector-ref (vector-ref grid-vec 0) 0) 0)
        1
        -1))

  ;; If start or end cell is blocked (value is 1)
  (when (or (= (vector-ref (vector-ref grid-vec 0) 0) 1)
            (= (vector-ref (vector-ref grid-vec (- n 1)) (- n 1)) 1))
    -1)

  ;; Initialize queue for BFS
  (define q (make-queue))
  ;; dists grid stores the shortest distance to a cell, 0 if not visited
  (define dists (make-vector n))
  (for ([i (in-range n)])
    (vector-set! dists i (make-vector n 0)))

  ;; 8 possible directions (horizontal, vertical, diagonal)
  (define dr '(-1 -1 -1 0 0 1 1 1))
  (define dc '(-1 0 1 -1 1 -1 0 1))

  ;; Enqueue starting cell (row, col, distance)
  (enqueue! q (list 0 0 1))
  (vector-set! (vector-ref dists 0) 0 1)

  (let bfs-loop ()
    (if (queue-empty? q)
        -1 ; Target not reached after exploring all reachable cells
        (let* ([current (dequeue! q)]
               [r (list-ref current 0)]
               [c (list-ref current 1)]
               [d (list-ref current 2)])

          ;; If target cell (n-1, n-1) is reached, return its distance
          (if (and (= r (- n 1)) (= c (- n 1)))
              d
              ;; Otherwise, explore neighbors and continue BFS
              (begin
                (for ([i (in-range 8)])
                  (define nr (+ r (list-ref dr i)))
                  (define nc (+ c (list-ref dc i)))

                  ;; Check if neighbor is within grid bounds
                  (when (and (>= nr 0) (< nr n)
                             (>= nc 0) (< nc n))
                    ;; Check if neighbor is traversable (value 0) and not yet visited
                    (when (and (= (vector-ref (vector-ref grid-vec nr) nc) 0)
                               (= (vector-ref (vector-ref dists nr) nc) 0))
                      ;; Mark as visited with current distance + 1
                      (vector-set! (vector-ref dists nr) nc (+ d 1))
                      ;; Enqueue neighbor
                      (enqueue! q (list nr nc (+ d 1)))))
                  )
                (bfs-loop))))))
  )