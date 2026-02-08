#lang racket

(require data/heap)

(define (time-taken-to-mark-all-nodes n edges disappearing-times)
  ;; Initialize adjacency list for an undirected graph
  (define adj (make-vector n '()))
  (for-each (lambda (edge)
              (define u (car edge))
              (define v (cadr edge))
              (define w (caddr edge))
              (vector-set! adj u (cons (list v w) (vector-ref adj u)))
              (vector-set! adj v (cons (list u w) (vector-ref adj v))))
            edges)

  ;; Initialize distances: shortest time to reach each node from the starting node (node 0)
  (define dist (make-vector n +inf.0))
  (vector-set! dist 0 0) ; Start at node 0 with time 0

  ;; Priority queue: (time . node)
  ;; Stores pairs (current-time-to-reach-node . node-index), ordered by time (smallest first)
  (define pq (heap-new (lambda (a b) (< (car a) (car b)))))
  (heap-add! pq (cons 0 0)) ; Add starting node (node 0, time 0)

  (let loop ()
    (when (not (heap-empty? pq))
      (define current (heap-min pq))
      (heap-remove! pq)

      (define d (car current)) ; current time to reach u
      (define u (cdr current)) ; current node

      ;; If we found a shorter path to u already, skip this entry
      (when (> d (vector-ref dist u))
        (loop))

      ;; Check if node u has disappeared by the time 'd'
      (define disappear-time-u (vector-ref disappearing-times u))
      (when (and (not (= disappear-time-u -1)) (>= d disappear-time-u))
        ;; Node u has disappeared by time 'd'. It cannot be marked, and it cannot be used to traverse further.
        ;; This path is considered invalid for further exploration.
        (loop))

      ;; Explore neighbors of u
      (for-each (lambda (neighbor)
                  (define v (car neighbor))
                  (define w (cadr neighbor))
                  (when (< (+ d w) (vector-ref dist v))
                    (vector-set! dist v (+ d w))
                    (heap-add! pq (cons (+ d w) v))))
                (vector-ref adj u))
      (loop)))

  ;; After Dijkstra's, `dist` contains the shortest path times to each node.
  ;; Now, construct the final `answer` array, considering the disappearing nodes constraint.
  (define answer (make-vector n -1))
  (for ([i (in-range n)])
    (when (not (= (vector-ref dist i) +inf.0)) ; If node i is reachable
      (define disappear-time-i (vector-ref disappearing-times i))
      ;; A node `i` is successfully marked if it's reachable at time `dist[i]`
      ;; AND `dist[i]` is strictly less than its `disappear-time-i` (if it has one).
      (when (or (= disappear-time-i -1) (< (vector-ref dist i) disappear-time-i))
        (vector-set! answer i (vector-ref dist i)))))

  answer)