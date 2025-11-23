(define (get-row rowIndex)
  (define (next-row prev)
    (if (null? prev)
        (list 1)
        (cons 1 (append (map (lambda (a b) (+ a b)) prev (cdr prev)) (list 1)))))
  (let loop ((n rowIndex) (row (list 1)))
    (if (= n 0)
        row
        (loop (- n 1) (next-row row)))))