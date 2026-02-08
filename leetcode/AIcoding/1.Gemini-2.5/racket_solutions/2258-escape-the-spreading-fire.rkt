#lang racket
(require data/queue)

(define (escape-the-spreading-fire grid)
  (define R (vector-length grid))
  (define C (vector-length (vector-ref grid 0)))

  (define DR (list -1 1 0 0))
  (define DC (list 0 0 -1 1))

  (define INF (expt 10 9)) ; A large number representing infinity

  ;; --- Step 1: Calculate fire spread times ---
  (define fire-spread-times (make-vector R))
  (for ([i (in-range R)])
    (vector-set! fire-spread-times i (make-vector C INF)))

  (define fire-q (make-queue))

  (for ([r (in-range R)])
    (for ([c (in-range C)])
      (when (= (vector-ref (vector-ref grid r) c) 1) ; If it's an initial fire cell
        (queue-add! fire-q (list r c 0))
        (vector-set! (vector-ref fire-spread-times r) c 0))))

  (let loop-fire ()
    (when (not (queue-empty? fire-q))
      (define current-fire (queue-remove! fire-q))
      (define r (list-ref current-fire 0))
      (define c (list-ref current-fire 1))
      (define t (list-ref current-fire 2))

      (for ([i (in-range 4)])
        (define nr (+ r (list-ref DR i)))
        (define nc (+ c (list-ref DC i)))

        (when (and (>= nr 0) (< nr R)
                   (>= nc 0) (< nc C)
                   (!= (vector-ref (vector-ref grid nr) nc) 2) ; Not a wall
                   (> (vector-ref (vector-ref fire-spread-times nr) nc) (+ t 1)))
          (vector-set! (vector-ref fire-spread-times nr) nc (+ t 1))
          (queue-add! fire-q (list nr nc (+ t 1)))))
      (loop-fire)))

  ;; --- Step 2: Check function for binary search ---
  (define (check wait-time)
    ;; If the starting cell (0,0) is burnt before we even start moving
    (if (>= wait-time (vector-ref (vector-ref fire-spread-times 0) 0))
        (if (and (= 0 (- R 1)) (= 0 (- C 1))) ; If start is end
            (<= wait-time (vector-ref (vector-ref fire-spread-times 0) 0)) ; If start is end, we can stay if fire arrives at or after wait-time
            #f) ; Otherwise, if start is burnt, cannot proceed
        (let () ; Proceed with BFS if (0,0) is safe at wait-time
          (define person-q (make-queue))
          (define visited (make-vector R))
          (for ([i (in-range R)])
            (vector-set! visited i (make-vector C INF))) ; Store min time to reach, init with INF

          (queue-add! person-q (list 0 0 wait-time))
          (vector-set! (vector-ref visited 0) 0 wait-time) ; Mark with time

          (let bfs-loop ()
            (if (queue-empty? person-q)
                #f ; No path found
                (let* ((current-person (queue-remove! person-q))
                       (r (list-ref current-person 0))
                       (c (list-ref current-person 1))
                       (current-time (list-ref current-person 2)))

                  ;; If we reached the destination
                  (if (and (= r (- R 1)) (= c (- C 1)))
                      ;; Check if fire reaches destination at or after us
                      (if (<= current-time (vector-ref (vector-ref fire-spread-times r) c))
                          #t ; Found a path, return true
                          (bfs-loop)) ; Reached destination but it's burnt, continue searching for other paths
                      (begin ; Not destination, continue exploring
                        (for ([i (in-range 4)])
                          (define nr (+ r (list-ref DR i)))
                          (define nc (+ c (list-ref DC i)))
                          (define next-time (+ current-time 1))

                          (when (and (>= nr 0) (< nr R)
                                     (>= nc 0) (< nc C)
                                     (!= (vector-ref (vector-ref grid nr) nc) 2) ; Not a wall
                                     (< next-time (vector-ref (vector-ref visited nr) nc))) ; Found a shorter path to (nr,nc)

                            (define fire-time-at-next-cell (vector-ref (vector-ref fire-spread-times nr) nc))

                            (cond
                              [(< next-time fire-time-at-next-cell) ; Safe to move to (nr, nc)
                               (vector-set! (vector-ref visited nr) nc next-time)
                               (queue-add! person-q (list nr nc next-time))]

                              [(and (= nr (- R 1)) (= nc (- C 1)) ; If it's the destination
                                    (<= next-time fire-time-at-next-cell)) ; And we arrive at or before fire
                               (vector-set! (vector-ref visited nr) nc next-time)
                               (queue-add! person-q (list nr nc next-time))]

                              [else #f])) ; Not safe to move to (nr, nc)
                        )
                        (bfs-loop)))))))) ; Continue BFS

  ;; --- Step 3: Binary Search for wait-time ---
  (define low 0)
  (define high (* R C 2)) ; A sufficiently large upper bound for wait_time + travel_time. Max R,C=200, so 200*200*2 = 80000.
  (define ans -1)

  (let bin-search-loop ((l low) (h high) (result ans))
    (if (> l h)
        result
        (let* ((mid (+ l (quotient (- h l) 2))))
          (if (check mid)
              (bin-search-loop (+ mid 1) h mid) ; `mid` is possible, try for more wait time
              (bin-search-loop l (- mid 1) result)))))
)