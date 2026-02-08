(define (canFinish numCourses prerequisites)
  (define graph (make-vector numCourses '()))
  (define visited (make-vector numCourses 0)) ; 0: unvisited, 1: visiting, 2: visited

  (for-each
   (lambda (p)
     (define course (car p))
     (define prereq (cadr p))
     ; Add an edge from prereq to course (prereq -> course)
     (vector-set! graph prereq (cons course (vector-ref graph prereq))))
   prerequisites)

  (define (dfs-check-cycle course)
    (vector-set! visited course 1) ; Mark as visiting (in current DFS path)

    (let loop ((neighbors (vector-ref graph course)))
      (cond
        ((empty? neighbors) #t) ; All neighbors processed without finding a cycle
        (else
         (define neighbor (car neighbors))
         (case (vector-ref visited neighbor)
           ((1) #f) ; Cycle detected: neighbor is currently visiting (back edge)
           ((0) (if (not (dfs-check-cycle neighbor)) ; Neighbor unvisited, recurse
                    #f ; Cycle found in sub-call, propagate
                    (loop (cdr neighbors)))) ; No cycle in sub-call, continue
           ((2) (loop (cdr neighbors))))))) ; Neighbor already fully visited, skip

    ; After processing all neighbors, if no cycle was found, mark this course as fully visited.
    (let ([result (loop (vector-ref graph course))])
      (when result
        (vector-set! visited course 2)) ; Mark as visited (finished processing)
      result))

  ; Main loop to start DFS from each unvisited course
  (let loop ([i 0])
    (cond
      ((= i numCourses) #t) ; All courses checked, no cycle found in the entire graph
      (else
       (case (vector-ref visited i)
         ((0) (if (not (dfs-check-cycle i))
                  #f ; Cycle found, return false immediately
                  (loop (+ i 1)))) ; No cycle, continue to next course
         (else (loop (+ i 1))))))) ; Already visited (either 1 or 2), skip and continue
)