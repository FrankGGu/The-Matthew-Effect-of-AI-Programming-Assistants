#lang racket

(define INF (expt 10 18)) ; A sufficiently large number for infinity

(define (shortest-distance-after-road-addition-queries-ii n queries)
  (define dist (make-vector n))

  ; Initialize distance matrix
  (for ([i (in-range n)])
    (vector-set! dist i (make-vector n INF))
    (vector-set! (vector-ref dist i) i 0))

  (define results '())

  (for ([q queries])
    (define u (car q))
    (define v (cadr q))
    (define w (caddr q))

    ; Update direct edge
    (vector-set! (vector-ref dist u) v (min (vector-ref (vector-ref dist u) v) w))
    (vector-set! (vector-ref dist v) u (min (vector-ref (vector-ref dist v) u) w))

    ; Update all-pairs shortest paths using the new edge
    (for ([i (in-range n)])
      (for ([j (in-range n)])
        ; Path i -> u -> v -> j
        (when (and (< (vector-ref (vector-ref dist i) u) INF)
                   (< (vector-ref (vector-ref dist u) v) INF) ; This is the potentially new direct path u-v
                   (< (vector-ref (vector-ref dist v) j) INF))
          (vector-set! (vector-ref dist i) j
                       (min (vector-ref (vector-ref dist i) j)
                            (+ (vector-ref (vector-ref dist i) u)
                               (vector-ref (vector-ref dist u) v)
                               (vector-ref (vector-ref dist v) j)))))

        ; Path i -> v -> u -> j
        (when (and (< (vector-ref (vector-ref dist i) v) INF)
                   (< (vector-ref (vector-ref dist v) u) INF) ; This is the potentially new direct path v-u
                   (< (vector-ref (vector-ref dist u) j) INF))
          (vector-set! (vector-ref dist i) j
                       (min (vector-ref (vector-ref dist i) j)
                            (+ (vector-ref (vector-ref dist i) v)
                               (vector-ref (vector-ref dist v) u)
                               (vector-ref (vector-ref dist u) j)))))))

    ; After each road addition, return the shortest distance from node 0 to node n-1.
    (define current-shortest-path (vector-ref (vector-ref dist 0) (- n 1)))
    (set! results (cons (if (= current-shortest-path INF) -1 current-shortest-path) results)))

  (reverse results))