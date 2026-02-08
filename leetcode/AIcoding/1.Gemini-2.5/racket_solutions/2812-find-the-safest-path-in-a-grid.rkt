#lang racket

(require racket/queue)

(define (maximum-safeness-factor grid)
  (define rows (vector-length grid))
  (define cols (vector-length (vector-ref grid 0)))

  (define (valid-pos r c)
    (and (>= r 0) (< r rows) (>= c 0) (< c cols)))

  (define dr '(-1 1 0 0))
  (define dc '(0 0 -1 1))

  ;; Step 1: Calculate min_dist to nearest thief for all cells using BFS
  (define dist-grid (make-vector rows (lambda () (make-vector cols -1))))
  (define q (make-queue))

  ;; Initialize queue with all thief cells and their distance (0)
  (for* ([r (in-range rows)]
         [c (in-range cols)])
    (when (= (vector-ref (vector-ref grid r) c) 1) ; If it's a thief
      (queue-put! q (list r c 0))
      (vector-set! (vector-ref dist-grid r) c 0)))

  ;; Perform BFS to fill dist-grid
  (let bfs-dist-loop ()
    (unless (queue-empty? q)
      (let* ([curr (queue-get! q)]
             [r (list-ref curr 0)]
             [c (list-ref curr 1)]
             [d (list-ref curr 2)])
        (for ([i (in-range 4)])
          (define nr (+ r (list-ref dr i)))
          (define nc (+ c (list-ref dc i)))
          (when (and (valid-pos nr nc)
                     (= (vector-ref (vector-ref dist-grid nr) nc) -1)) ; If not visited
            (vector-set! (vector-ref dist-grid nr) nc (+ d 1))
            (queue-put! q (list nr nc (+ d 1)))))
        (bfs-dist-loop))))

  ;; Step 2: Binary Search for the maximum safeness factor (k)
  (define low 0)
  (define high (let ([max-d 0])
                 (for* ([r (in-range rows)]
                        [c (in-range cols)])
                   (set! max-d (max max-d (vector-ref (vector-ref dist-grid r) c))))
                 max-d))
  (define ans 0)

  ;; Helper function to check if a path exists with all cells having min_dist >= k
  (define (can-reach? k)
    ;; If the starting cell itself doesn't meet the safeness factor, no path.
    (when (< (vector-ref (vector-ref dist-grid 0) 0) k)
      #f)

    (define visited (make-vector rows (lambda () (make-vector cols #f))))
    (define q-path (make-queue))

    (queue-put! q-path (list 0 0))
    (vector-set! (vector-ref visited 0) 0 #t)

    (let bfs-path-loop ()
      (if (queue-empty? q-path)
          #f ; No path found
          (let* ([curr (queue-get! q-path)]
                 [r (list-ref curr 0)]
                 [c (list-ref curr 1)])
            (if (and (= r (- rows 1)) (= c (- cols 1)))
                #t ; Target reached
                (begin
                  (for ([i (in-range 4)])
                    (define nr (+ r (list-ref dr i)))
                    (define nc (+ c (list-ref dc i)))
                    (when (and (valid-pos nr nc)
                               (not (vector-ref (vector-ref visited nr) nc))
                               (>= (vector-ref (vector-ref dist-grid nr) nc) k))
                      (vector-set! (vector-ref visited nr) nc #t)
                      (queue-put! q-path (list nr nc))))
                  (bfs-path-loop))))))

  ;; Binary search loop
  (let loop-bs ([low low] [high high] [ans ans])
    (if (> low high)
        ans
        (let* ([mid (quotient (+ low high) 2)])
          (if (can-reach? mid)
              (loop-bs (+ mid 1) high mid) ; Try for a higher safeness factor
              (loop-bs low (- mid 1) ans))))))