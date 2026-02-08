(define (swim-in-water grid)
  (define n (length grid))
  (define (can-swim time)
    (define visited (make-vector n (make-vector n #f)))
    (define (dfs x y)
      (if (or (< x 0) (>= x n) (< y 0) (>= y n) (vector-ref (vector-ref visited x) y) (>= (vector-ref (vector-ref grid x) y) time))
          #f)
        #f
        (begin
          (vector-set! (vector-ref visited x) y #t)
          (or (and (= x (- n 1)) (= y (- n 1)))
              (or (dfs (+ x 1) y) (dfs (- x 1) y) (dfs x (+ y 1)) (dfs x (- y 1)))))))
    (dfs 0 0))

  (define (binary-search left right)
    (if (= left right)
        left
        (let ((mid (quotient (+ left right) 2)))
          (if (can-swim mid)
              (binary-search left mid)
              (binary-search (+ mid 1) right)))))

  (binary-search 0 (apply max (apply append grid)))
)