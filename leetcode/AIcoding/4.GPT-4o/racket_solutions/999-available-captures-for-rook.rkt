(define (numRookCaptures board)
  (define (count-captures dir)
    (let loop ((x (car dir)) (y (cadr dir)) (count 0))
      (cond
        ((or (< x 0) (>= x 8) (< y 0) (>= y 8)) count)
        ((equal? (list-ref (list-ref board x) y) "p") (loop (+ x (car dir)) (+ y (cadr dir)) (+ count 1)))
        ((equal? (list-ref (list-ref board x) y) ".") (loop (+ x (car dir)) (+ y (cadr dir)) count))
        (else count))))

  (define rook-pos
    (for/fold ((x -1) (y -1)) ((i (in-range 8)) (j (in-range 8)))
      (if (equal? (list-ref (list-ref board i) j) "R")
          (values i j)
          (values x y))))

  (if (or (= (car rook-pos) -1) (= (cadr rook-pos) -1))
      0
      (+ (count-captures '(0 1)) (count-captures '(0 -1)) (count-captures '(1 0)) (count-captures '(-1 0))))))