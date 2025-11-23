(define (minOperations grid)
  (define n (length grid))
  (define m (length (car grid)))
  (define (transpose matrix)
    (apply map list matrix))
  (define transposed-grid (transpose grid))

  (define (min-ops col)
    (define sorted-col (sort col <))
    (define (helper lst prev ops)
      (if (null? lst)
          ops
          (let ((current (car lst)))
            (if (<= current prev)
                (helper (cdr lst) (+ prev 1) (+ ops (- prev current)))
                (helper (cdr lst) current ops)))))
    (helper sorted-col -1 0))

  (define ops (map min-ops transposed-grid))
  (apply + ops))

(minOperations [[1, 4, 3], [3, 3, 2], [2, 1, 1]])