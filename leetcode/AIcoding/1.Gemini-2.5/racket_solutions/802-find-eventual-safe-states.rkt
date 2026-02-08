#lang racket

(define (safe-states graph)
  (define n (vector-length graph))
  (define states (make-vector n 0)) ; 0: unvisited, 1: visiting, 2: safe, 3: unsafe

  (define (dfs node)
    (case (vector-ref states node)
      ((1) ; Currently visiting, means cycle detected
       (vector-set! states node 3) ; Mark as unsafe
       #f)
      ((2) ; Already known to be safe
       #t)
      ((3) ; Already known to be unsafe
       #f)
      (else ; Unvisited (state 0)
       (vector-set! states node 1) ; Mark as visiting

       (define all-neighbors-safe?
         (andmap dfs (vector-ref graph node)))

       (if all-neighbors-safe?
           (begin (vector-set! states node 2) #t) ; Mark safe
           (begin (vector-set! states node 3) #f))))) ; Mark unsafe

  (for ([i (in-range n)])
    (when (= (vector-ref states i) 0)
      (dfs i)))

  (filter (lambda (i) (= (vector-ref states i) 2))
          (build-list n identity)))