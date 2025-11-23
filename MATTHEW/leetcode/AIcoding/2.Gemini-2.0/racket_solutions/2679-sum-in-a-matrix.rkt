(define (matrix-sum matrix)
  (let loop ((matrix matrix) (total 0))
    (if (null? matrix)
        total
        (let* ((row (car matrix))
               (max-val (apply max row)))
          (loop (cdr matrix) (+ total max-val))))))

(define (matrix-sum-optimized matrix)
  (let* ((num-cols (length (car matrix)))
         (cols (for/list ((i (in-range num-cols)))
                 (for/list ((row (in-list matrix)))
                   (list-ref row i)))))
    (let loop ((cols cols) (total 0))
      (if (null? cols)
          total
          (let* ((col (car cols))
                 (max-val (apply max col)))
            (loop (cdr cols) (+ total max-val)))))))

(define (solve matrix)
  (matrix-sum-optimized matrix))