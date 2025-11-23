(define (is-safe? grid x y visited)
  (and (>= x 0) (< x (vector-length grid))
       (>= y 0) (< y (vector-length (vector-ref grid 0)))
       (not (vector-ref visited x y))
       (not (= (vector-ref (vector-ref grid x) y) 1))))

(define (dfs grid x y visited)
  (if (and (= x (- (vector-length grid) 1)) (= y (- (vector-length (vector-ref grid 0)) 1)))
      (begin (vector-set! visited x y #t) (list x y))
      (begin
        (vector-set! visited x y #t)
        (for/or ([dx '(0 1 0 -1)]
                  [dy '(1 0 -1 0)])
          (let* ([nx (+ x dx)]
                 [ny (+ y dy)])
            (when (is-safe? grid nx ny visited)
              (let ([result (dfs grid nx ny visited)])
                (when result
                  (begin
                    (vector-set! visited x y #f)
                    (cons (list x y) result)))))))))))

(define (find-safe-path grid)
  (let ([visited (make-vector (vector-length grid) (lambda () (make-vector (vector-length (vector-ref grid 0)) #f)))])
        [path (dfs grid 0 0 visited)])
    (if path (reverse path) '())))

(define (findSafePath grid)
  (find-safe-path (vector->list grid)))