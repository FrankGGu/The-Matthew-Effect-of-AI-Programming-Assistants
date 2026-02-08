(define (moves-to-chessboard board)
  (define n (length board))
  (define (count-moves row)
    (let* ([ones (count (lambda (x) (= x 1)) row)]
           [diff (abs (- ones (/ n 2)))])
      (if (or (odd? n) (= diff 0))
          (let ([first-zero (for/first ([i (in-range n)])
                               (when (= (list-ref row i) 0)
                                 i))])
            (if (null? first-zero)
                0
                (let ([moves (count (lambda (x) (= x 1))
                                    (for/list ([i (in-range n)])
                                      (if (even? i)
                                          (list-ref row i)
                                          (- 1 (list-ref row i)))))]))
                (min moves (- n moves))))
          -1)))

  (define (check-valid)
    (let ([row-counts (map (lambda (row) (count (lambda (x) (= x 1)) row)) board)]
          [col-counts (map (lambda (col) (count (lambda (row) (= (list-ref row col) 1)) board)) (range n))])
      (and (ormap (lambda (count) (not (= count (/ n 2)))) row-counts)
           (ormap (lambda (count) (not (= count (/ n 2)))) col-counts))))

  (let ([row-moves (count-moves (car board))]
        [col-moves (count-moves (map car board))])
    (cond
      [(not (equal? (length (remove-duplicates (map (lambda (row) (list->string (map number->string row))) board))) 2)) -1]
      [(not (equal? (length (remove-duplicates (map (lambda (col) (list->string (map number->string (map car board)))) (range n)))) 2)) -1]
      [(< row-moves 0) (if (< col-moves 0) -1 col-moves)]
      [(< col-moves 0) row-moves]
      [else (+ (/ row-moves 2) (/ col-moves 2))]))))