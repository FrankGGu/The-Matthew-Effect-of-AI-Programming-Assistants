(define (island-perimeter grid)
  (define (is-land? i j)
    (and (>= i 0) (< i (length grid)) (>= j 0) (< j (length (first grid))) (= (list-ref (list-ref grid i) j) 1)))
  (define (count-perimeter i j)
    (if (is-land? i j)
      (foldl (lambda (d acc)
                (+ acc (if (is-land? (+ i (car d)) (+ j (cadr d))) 0 1)))
              0 '((0 -1) (0 1) (-1 0) (1 0)))
      0))
  (define total-perimeter
    (for/sum ([i (in-range (length grid))]
               [j (in-range (length (first grid)))])
      (count-perimeter i j)))
  total-perimeter)