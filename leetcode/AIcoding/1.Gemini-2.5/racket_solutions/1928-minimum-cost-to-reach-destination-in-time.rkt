#lang racket

(require data/heap)
(require math/flonum)

(define (min-cost-to-reach-destination-in-time n flights maxTime)
  (define +infinity +inf.0)

  ;; Build adjacency list
  ;; adj[u] will be a list of (v time cost)
  (define adj (make-vector n null))
  (for-each (lambda (flight)
              (define u (vector-ref flight 0))
              (define v (vector-ref flight 1))
              (define t (vector-ref flight 2))
              (define c (vector-ref flight 3))
              (vector-set! adj u (cons (list v t c) (vector-ref adj u))))
            flights)

  ;; dp[city][time] = minimum cost to reach 'city' at 'time'
  ;; Initialize dp table with infinity
  (define dp (for/vector ([i n])
               (for/vector ([j (+ maxTime 1)])
                 +infinity)))

  ;; Priority queue stores (cost time city)
  ;; Prioritize by cost (min-heap)
  (define pq (make-heap (lambda (a b) (< (car a) (car b)))))

  ;; Initial state: start at city 0 at time 0 with cost 0
  (vector-set! (vector-ref dp 0) 0 0)
  (heap-add! pq (list 0 0 0))

  (while (not (heap-empty? pq))
    (define current-state (heap-min pq))
    (heap-remove! pq)

    (define current-cost (list-ref current-state 0))
    (define current-time (list-ref current-state 1))
    (define current-city (list-ref current-state 2))

    ;; If we've found a cheaper path to this state, skip
    (when (<= current-cost (vector-ref (vector-ref dp current-city) current-time))
      (for-each (lambda (flight-info)
                  (define next-city (list-ref flight-info 0))
                  (define flight-time (list-ref flight-info 1))
                  (define flight-cost (list-ref flight-info 2))

                  (define next-time (+ current-time flight-time))
                  (define next-cost (+ current-cost flight-cost))

                  (when (<= next-time maxTime)
                    (when (< next-cost (vector-ref (vector-ref dp next-city) next-time))
                      (vector-set! (vector-ref dp next-city) next-time next-cost)
                      (heap-add! pq (list next-cost next-time next-city)))))
                (vector-ref adj current-city))))

  ;; Find the minimum cost to reach the destination city (n-1) within maxTime
  (define min-final-cost +infinity)
  (define dest-dp-row (vector-ref dp (- n 1)))
  (for ([t (in-range (+ maxTime 1))])
    (set! min-final-cost (min min-final-cost (vector-ref dest-dp-row t))))

  (if (= min-final-cost +infinity)
      -1
      min-final-cost))