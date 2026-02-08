(define (min-reorder n connections)
  (define graph (make-vector n '())) ; Adjacency list: (vector (list (neighbor cost) ...) ...)

  ; Build the graph representing both original and reverse paths
  (for-each
   (lambda (conn)
     (define u (car conn))
     (define v (cadr conn))
     ; For an original directed edge u -> v:
     ; Add (v, 1) to u's list: If we traverse u -> v, it means v is further from 0.
     ; To make a path from v to 0 through u, the edge u->v needs to be reversed to v->u. Cost = 1.
     (vector-set! graph u (cons (list v 1) (vector-ref graph u)))
     ; Add (u, 0) to v's list: If we traverse v -> u, it means u is closer to 0.
     ; This path v->u is desired for v to reach 0. No reversal needed for this direction. Cost = 0.
     (vector-set! graph v (cons (list u 0) (vector-ref graph v))))
   connections)

  (define visited (make-vector n #f)) ; Boolean vector to track visited cities
  (define reversals 0) ; Counter for reorientations needed

  ; Depth-First Search function
  (define (dfs u)
    (vector-set! visited u #t) ; Mark current city u as visited
    (for-each
     (lambda (neighbor-info)
       (define v (car neighbor-info))
       (define cost (cadr neighbor-info))
       (when (not (vector-ref visited v)) ; If neighbor v has not been visited
         (set! reversals (+ reversals cost)) ; Add the cost (0 or 1) to the total reversals
         (dfs v))) ; Recursively call DFS on neighbor v
     (vector-ref graph u)))

  ; Start DFS from city 0
  (dfs 0)

  reversals) ; Return the total number of reorientations