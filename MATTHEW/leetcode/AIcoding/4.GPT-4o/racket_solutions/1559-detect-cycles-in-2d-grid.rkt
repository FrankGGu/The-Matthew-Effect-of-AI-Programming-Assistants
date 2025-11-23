(define (containsCycle grid)
  (define (dfs x y prev-x prev-y)
    (if (or (< x 0) (>= x (length grid)) (< y 0) (>= (length (vector-ref grid x)) (length grid)))
        #f
        (let ([curr (vector-ref (vector-ref grid x) y)])
          (if (or (equal? (vector-ref visited x y) #t) 
                  (not (equal? curr (vector-ref (vector-ref grid prev-x) prev-y))))
              #f
              (begin
                (set! (vector-ref visited x y) #t)
                (or (and (not (equal? curr (vector-ref (vector-ref grid prev-x) prev-y))) 
                         (dfs (+ x 1) y x y))
                    (and (not (equal? curr (vector-ref (vector-ref grid prev-x) prev-y))) 
                         (dfs (- x 1) y x y))
                    (and (not (equal? curr (vector-ref (vector-ref grid prev-x) prev-y))) 
                         (dfs x (+ y 1) x y))
                    (and (not (equal? curr (vector-ref (vector-ref grid prev-x) prev-y))) 
                         (dfs x (- y 1) x y)))))))

  (define visited (make-vector (length grid) (lambda () (make-vector (length (vector-ref grid 0)) #f))))
  (define has-cycle #f)

  (for ([i (in-range (length grid))])
    (for ([j (in-range (length (vector-ref grid i)))])
      (when (not (vector-ref visited i j))
        (set! has-cycle (or has-cycle (dfs i j -1 -1))))))

  has-cycle)