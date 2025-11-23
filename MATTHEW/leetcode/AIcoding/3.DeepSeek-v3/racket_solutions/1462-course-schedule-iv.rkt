#lang racket

(define (check-if-prerequisite numCourses prerequisites queries)
  (define adj (make-vector numCourses null))
  (define reachable (make-hash))

  (for ([prereq prerequisites])
    (let ([u (car prereq)]
          [v (cadr prereq)])
      (vector-set! adj u (cons v (vector-ref adj u)))))

  (define (dfs u)
    (if (hash-has-key? reachable u)
        (hash-ref reachable u)
        (let ([res (mutable-set)])
          (for ([v (vector-ref adj u)])
          (for ([v (vector-ref adj u)])
          (for ([v (vector-ref adj u)])
            (set-add! res v)
            (set-union! res (dfs v)))
          (hash-set! reachable u res)
          res)))

  (for ([i (in-range numCourses)])
    (dfs i))

  (for/list ([query queries])
    (let ([u (car query)]
          [v (cadr query)])
      (if (set-member? (hash-ref reachable u (set)) v)
          #t
          #f))))