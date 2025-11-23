#lang racket

(define (hasValidPath grid)
  (define m (length grid))
  (define n (if (null? grid) 0 (length (car grid))))
  (define visited (make-vector (* m n) #f))
  (define (valid? x y) (and (>= x 0) (< x m) (>= y 0) (< y n)))
  (define (get-index x y) (+ (* x n) y))

  (define (can-go? from to dir)
    (case dir
      [(0) (and (or (= to 1) (= to 3) (= to 5))] ; left
      [(1) (and (or (= to 1) (= to 4) (= to 6))] ; right
      [(2) (and (or (= to 2) (= to 5) (= to 6))] ; up
      [(3) (and (or (= to 2) (= to 3) (= to 4)))])) ; down

  (define (get-next x y)
    (let ([street (list-ref (list-ref grid x) y)])
      (for/list ([dir (case street
                         [(1) '(0 1)]
                         [(2) '(2 3)]
                         [(3) '(0 3)]
                         [(4) '(1 3)]
                         [(5) '(0 2)]
                         [(6) '(1 2)])])
        (let-values ([(nx ny) (case dir
                                [(0) (values x (- y 1))]
                                [(1) (values x (+ y 1))]
                                [(2) (values (- x 1) y)]
                                [(3) (values (+ x 1) y)])])
          (if (and (valid? nx ny) 
                   (can-go? dir (list-ref (list-ref grid nx) ny) (bitwise-xor dir 1)))
            (cons nx ny)
            #f)))))

  (define (dfs x y)
    (if (and (= x (- m 1)) (= y (- n 1)))
        #t
        (let ([idx (get-index x y)])
          (vector-set! visited idx #t)
          (for/or ([next (filter values (get-next x y))])
            (let ([nx (car next)]
                  [ny (cdr next)])
              (if (not (vector-ref visited (get-index nx ny)))
                  (dfs nx ny)
                  #f))))))

  (if (or (zero? m) (zero? n))
      #f
      (dfs 0 0)))