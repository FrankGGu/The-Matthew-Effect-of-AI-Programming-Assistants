#lang racket

(require data/queue)

(define (maximum-safeness-factor grid)
  (define m (vector-length grid))
  (define n (vector-length (vector-ref grid 0)))

  ;; Step 1: Precompute distances to thieves using multi-source BFS
  ;; Initialize dist with a large number representing infinity.
  ;; Max possible Manhattan distance in an m x n grid is m + n - 2.
  ;; So, m*n + 1 is a safe upper bound for infinity.
  (define infinity (+ (* m n) 1))
  (define dist (make-vector m))
  (for ([i (in-range m)])
    (vector-set! dist i (make-vector n infinity)))

  (define q (make-queue))

  ;; Initialize queue with all thief locations and set their distance to 0
  (for* ([r (in-range m)]
         [c (in-range n)])
    (when (= (vector-ref (vector-ref grid r) c) 1)
      (enqueue! q (list r c))
      (vector-set! (vector-ref dist r) c 0)))

  (define dr (list -1 1 0 0))
  (define dc (list 0 0 -1 1))

  (let loop ()
    (when (not (queue-empty? q))
      (define current (dequeue! q))
      (define r (car current))
      (define c (cadr current))
      (define current-dist (vector-ref (vector-ref dist r) c))

      (for ([i (in-range 4)])
        (define nr (+ r (list-ref dr i)))
        (define nc (+ c (list-ref dc i)))

        (when (and (>= nr 0) (< nr m)
                   (>= nc 0) (< nc n)
                   (> (vector-ref (vector-ref dist nr) nc) (+ current-dist 1))) ; If current path is shorter
          (vector-set! (vector-ref dist nr) nc (+ current-dist 1))
          (enqueue! q (list nr nc))))
      (loop)))

  ;; Step 2 & 3: Binary Search on the safety factor
  (define (can-reach? k)
    ;; If the start cell itself has a safeness factor less than k, no path can start.
    (when (< (vector-ref (vector-ref dist 0) 0) k)
      (values #f))

    (define visited (make-vector m))
    (for ([i (in-range m)])
      (vector-set! visited i (make-vector n #f)))

    (define bfs-q (make-queue))

    (enqueue! bfs-q (list 0 0))
    (vector-set! (vector-ref visited 0) 0 #t)

    (let bfs-loop ()
      (when (not (queue-empty? bfs-q))
        (define current (dequeue! bfs-q))
        (define r (car current))
        (define c (cadr current))

        (when (and (= r (- m 1)) (= c (- n 1)))
          (values #t)) ; Reached destination

        (for ([i (in-range 4)])
          (define nr (+ r (list-ref dr i)))
          (define nc (+ c (list-ref dc i)))

          (when (and (>= nr 0) (< nr m)
                     (>= nc 0) (< nc n)
                     (not (vector-ref (vector-ref visited nr) nc))
                     (>= (vector-ref (vector-ref dist nr) nc) k)) ; Only move to cells with sufficient safeness
            (vector-set! (vector-ref visited nr) nc #t)
            (enqueue! bfs-q (list nr nc))))
        (bfs-loop)))
    #f) ; Did not reach destination

  ;; Binary search range for k
  ;; The maximum possible safeness factor can be up to m + n - 2 (Manhattan distance).
  ;; A safe upper bound for binary search is m + n.
  (define low 0)
  (define high (+ m n))
  (define ans 0)

  (let bin-search-loop ()
    (when (<= low high)
      (define mid (quotient (+ low high) 2))
      ;; The can-reach? function already checks if dist[0][0] >= k.
      (if (can-reach? mid)
          (begin
            (set! ans mid)
            (set! low (+ mid 1)))
          (set! high (- mid 1))))
    (bin-search-loop))

  ans)