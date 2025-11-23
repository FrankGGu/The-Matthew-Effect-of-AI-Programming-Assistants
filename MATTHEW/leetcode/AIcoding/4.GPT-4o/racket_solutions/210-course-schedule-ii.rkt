(define (findOrder numCourses prerequisites)
  (define graph (make-vector numCourses '()))
  (for-each (lambda (prereq)
              (define u (car prereq))
              (define v (cadr prereq))
              (vector-set! graph v (cons u (vector-ref graph v))))
            prerequisites)

  (define visited (make-vector numCourses #f))
  (define temp (make-vector numCourses #f))
  (define result '())
  (define hasCycle #f)

  (define (dfs node)
    (set! temp node #t)
    (for-each (lambda (neighbor)
                (if (vector-ref temp neighbor)
                    (set! hasCycle #t)
                    (if (and (not (vector-ref visited neighbor))
                             (not hasCycle))
                        (begin
                          (dfs neighbor))))
                )
              (vector-ref graph node))
    (set! visited node #t)
    (set! temp node #f)
    (set! result (cons node result)))

  (for ([i (in-range numCourses)])
    (if (not (vector-ref visited i))
        (dfs i)))

  (if hasCycle
      '()
      (reverse result)))

(findOrder 4 '((1 0) (2 1) (3 2)))