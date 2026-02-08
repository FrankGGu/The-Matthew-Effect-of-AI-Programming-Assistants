#lang racket

(require racket/queue)

(define (shortest-alternating-paths n red-edges blue-edges)
  ;; Adjacency lists for red and blue edges
  (define adj-red (make-vector n '()))
  (define adj-blue (make-vector n '()))

  ;; Populate adjacency lists for red edges
  (for-each (lambda (edge)
              (define u (car edge))
              (define v (cadr edge))
              (vector-set! adj-red u (cons v (vector-ref adj-red u))))
            red-edges)

  ;; Populate adjacency lists for blue edges
  (for-each (lambda (edge)
              (define u (car edge))
              (define v (cadr edge))
              (vector-set! adj-blue u (cons v (vector-ref adj-blue u))))
            blue-edges)

  ;; dist[node][last_color] stores the shortest path from node 0 to 'node'
  ;; such that the last edge taken was of 'last_color'.
  ;; last_color: 0 for red, 1 for blue.
  (define dist (make-vector n (vector +inf.0 +inf.0)))

  ;; Initialize distance for node 0.
  ;; Conceptually, node 0 can be reached with a "red" or "blue" edge of length 0.
  (vector-set! (vector-ref dist 0) 0 0)
  (vector-set! (vector-ref dist 0) 1 0)

  ;; BFS queue stores (node last_color distance)
  (define q (make-queue))
  (enqueue! q (list 0 0 0)) ; Start from node 0, last edge was red (conceptually), distance 0
  (enqueue! q (list 0 1 0)) ; Start from node 0, last edge was blue (conceptually), distance 0

  ;; BFS loop
  (let loop ()
    (when (not (queue-empty? q))
      (define current (dequeue! q))
      (define u (car current))
      (define last-color (cadr current))
      (define d (caddr current))

      ;; If the last edge taken was red (0), the next edge must be blue (1)
      (when (= last-color 0)
        (define next-color 1)
        (for-each (lambda (v)
                    ;; If a shorter path to v ending with a blue edge is found
                    (when (> (vector-ref (vector-ref dist v) next-color) (+ d 1))
                      (vector-set! (vector-ref dist v) next-color (+ d 1))
                      (enqueue! q (list v next-color (+ d 1)))))
                  (vector-ref adj-blue u)))

      ;; If the last edge taken was blue (1), the next edge must be red (0)
      (when (= last-color 1)
        (define next-color 0)
        (for-each (lambda (v)
                    ;; If a shorter path to v ending with a red edge is found
                    (when (> (vector-ref (vector-ref dist v) next-color) (+ d 1))
                      (vector-set! (vector-ref dist v) next-color (+ d 1))
                      (enqueue! q (list v next-color (+ d 1)))))
                  (vector-ref adj-red u)))
      (loop)))

  ;; Construct the final result array
  (define result (make-vector n))
  (for ([i (in-range n)])
    ;; The shortest path to node i is the minimum of paths ending with red or blue edges
    (define min-dist (min (vector-ref (vector-ref dist i) 0)
                          (vector-ref (vector-ref dist i) 1)))
    (if (= min-dist +inf.0)
        (vector-set! result i -1) ; If unreachable, set to -1
        (vector-set! result i min-dist)))
  result)