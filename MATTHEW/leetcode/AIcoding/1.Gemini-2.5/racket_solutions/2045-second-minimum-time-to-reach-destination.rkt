#lang racket

(require racket/queue)

(define (second-minimum-time n edges time change)
  ;; Adjacency list representation of the graph
  (define adj (make-vector n '()))
  (for-each (lambda (edge)
              (define u (car edge))
              (define v (cadr edge))
              (vector-set! adj u (cons v (vector-ref adj u)))
              (vector-set! adj v (cons u (vector-ref adj v))))
            edges)

  ;; min-times[i] stores (list first_min_time second_min_time) to reach node i.
  ;; Initialize with +inf.0 (positive infinity).
  (define min-times (make-vector n (list +inf.0 +inf.0)))
  ;; Starting node 0 takes 0 time to reach itself.
  (vector-set! min-times 0 (list 0 +inf.0))

  ;; Queue for BFS: elements are (list node current-arrival-time)
  (define q (make-queue))
  (enqueue! q (list 0 0))

  ;; BFS loop
  (let loop ()
    (when (not (queue-empty? q))
      (define-values (u current-arrival-time) (apply values (dequeue! q)))

      ;; Calculate time to depart from node u, considering traffic lights
      (define num-cycles (floor-quotient current-arrival-time change))
      (define time-in-cycle (remainder current-arrival-time change))
      (define is-red? (>= time-in-cycle (/ change 2)))

      (define wait-time (if is-red?
                            (- (* (+ num-cycles 1) change) current-arrival-time)
                            0))
      (define time-to-depart (+ current-arrival-time wait-time))

      ;; Explore neighbors
      (for-each (lambda (v)
                  (define next-arrival-time (+ time-to-depart time))

                  (define v-times (vector-ref min-times v))
                  (define v-time1 (car v-times))
                  (define v-time2 (cadr v-times))

                  (cond
                    ;; Case 1: Found a new shortest path to v
                    [(< next-arrival-time v-time1)
                     (vector-set! min-times v (list next-arrival-time v-time1))
                     (enqueue! q (list v next-arrival-time))]
                    ;; Case 2: Found a new second shortest path to v (must be distinct from v-time1)
                    [(and (> next-arrival-time v-time1) (< next-arrival-time v-time2))
                     (vector-set! min-times v (list v-time1 next-arrival-time))
                     (enqueue! q (list v next-arrival-time))]))
                (vector-ref adj u))
      (loop)))

  ;; The result is the second minimum time to reach the destination node (n-1)
  (second (vector-ref min-times (- n 1))))