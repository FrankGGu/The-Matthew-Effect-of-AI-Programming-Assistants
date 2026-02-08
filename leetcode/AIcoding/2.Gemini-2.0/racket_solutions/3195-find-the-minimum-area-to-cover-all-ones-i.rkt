(define (min-area-rect matrix)
  (define rows (length matrix))
  (define cols (length (first matrix)))

  (define ones (for/list ([i (in-range rows)]
                         [j (in-range cols)]
                         #:when (= (list-ref (list-ref matrix i) j) 1))
                  (cons i j)))

  (if (null? ones)
      0
      (let* ([min-row (apply min (map car ones))]
             [max-row (apply max (map car ones))]
             [min-col (apply min (map cdr ones))]
             [max-col (apply max (map cdr ones))])
        (* (+ 1 (- max-row min-row)) (+ 1 (- max-col min-col))))))