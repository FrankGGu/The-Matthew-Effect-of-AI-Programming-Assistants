(define (findOrder numCourses prerequisites)
  (define graph (make-hash))
  (for ([i (range numCourses)])
    (hash-set! graph i '()))

  (for ([prereq prerequisites])
    (define course (car prereq))
    (define pre (cadr prereq))
    (hash-set! graph pre (cons course (hash-ref graph pre))))

  (define visited-states (make-vector numCourses 0)) ; 0: unvisited, 1: visiting, 2: visited
  (define result '())
  (define cycle-found #f)

  (define (dfs course)
    (when cycle-found
      (void))

    (vector-set! visited-states course 1) ; Mark as visiting

    (for ([neighbor (hash-ref graph course)])
      (case (vector-ref visited-states neighbor)
        [(1) ; Visiting, means cycle detected
         (set! cycle-found #t)
         (void)]
        [(0) ; Unvisited, recurse
         (dfs neighbor)]
        [(2) ; Visited, skip
         (void)]))

    (unless cycle-found
      (vector-set! visited-states course 2) ; Mark as visited
      (set! result (cons course result)))) ; Prepend to result

  (for ([i (range numCourses)])
    (when (and (not cycle-found) (= (vector-ref visited-states i) 0))
      (dfs i)))

  (if cycle-found
      '()
      result))