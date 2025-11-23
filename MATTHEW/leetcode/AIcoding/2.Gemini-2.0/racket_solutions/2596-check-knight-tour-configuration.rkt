(define (check-valid-grid grid)
  (define n (vector-length grid))
  (define (valid-move? x y next-x next-y)
    (and (>= next-x 0) (< next-x n) (>= next-y 0) (< next-y n)
         (= (abs (- x next-x)) 1) (= (abs (- y next-y)) 2)
         (not (= (abs (- x next-x)) (abs (- y next-y))))))

  (define (solve x y count)
    (cond
      [(= count (* n n)) #t]
      [else
       (let ([next-x (vector-ref (vector-ref grid x) y)])
         (if (= next-x count)
             (let loop ([dx '(-1 -2 1 2 -1 -2 1 2)]
                        [dy '(-2 -1 -2 -1 2 1 2 1)])
               (cond
                 [(null? dx) #f]
                 [(valid-move? x y (modulo (+ x (car dx)) n) (modulo (+ y (car dy)) n))
                  (let ([nx (modulo (+ x (car dx)) n)]
                        [ny (modulo (+ y (car dy)) n)])
                    (if (= (vector-ref (vector-ref grid nx) ny) (+ count 1))
                        (solve nx ny (+ count 1))
                        (loop (cdr dx) (cdr dy))))]
                 [else (loop (cdr dx) (cdr dy))]))
             #f))]))
  (if (= (vector-ref (vector-ref grid 0) 0) 0)
      (solve 0 0 0)
      #f))