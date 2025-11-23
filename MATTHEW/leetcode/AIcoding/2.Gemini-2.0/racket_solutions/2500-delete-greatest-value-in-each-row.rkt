(define (delete-greatest-value-in-each-row grid)
  (let* ((rows (length grid))
         (cols (length (car grid)))
         (sorted-grid (map sort grid)))
    (let loop ((col 0) (max-sum 0))
      (if (= col cols)
          max-sum
          (let ((max-val (apply max (map (lambda (row) (list-ref row (- cols 1 col 1))) sorted-grid))))
            (loop (+ col 1) (+ max-sum max-val)))))))