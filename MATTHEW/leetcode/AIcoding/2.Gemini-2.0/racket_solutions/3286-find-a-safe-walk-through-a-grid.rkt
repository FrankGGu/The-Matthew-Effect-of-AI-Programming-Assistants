(define (is-safe-walk grid)
  (let* ((m (length grid))
         (n (length (car grid)))
         (visited (make-vector m (make-vector n #f)))
         (directions '((0 1) (0 -1) (1 0) (-1 0))))

    (define (is-valid? row col)
      (and (>= row 0) (< row m) (>= col 0) (< col n) (not (vector-ref (vector-ref visited row) col)) (= (vector-ref (vector-ref grid row) col) 0)))

    (define (dfs row col)
      (if (and (= row (sub1 m)) (= col (sub1 n)))
          #t
          (begin
            (vector-set! (vector-ref visited row) col #t)
            (for/or ((dir directions))
              (let ((new-row (+ row (car dir)))
                    (new-col (+ col (cadr dir))))
                (and (is-valid? new-row new-col) (dfs new-row new-col)))))))

    (if (= (vector-ref (vector-ref grid 0) 0) 1)
        #f
        (dfs 0 0))))