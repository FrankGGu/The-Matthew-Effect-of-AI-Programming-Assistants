(define (count-set-bits row)
  (apply + row))

(define (row-or row1 row2)
  (map (lambda (b1 b2) (if (or (= b1 1) (= b2 1)) 1 0)) row1 row2))

(define (find-good-subset grid)
  (define m (length grid))
  (define n (length (car grid)))
  (define n/2 (floor (/ n 2)))

  ;; Check single rows
  (for/first ([i (in-range m)]
              #:when (<= (count-set-bits (list-ref grid i)) n/2))
    (list i)
    #:else
    ;; If no single row is good, check pairs of rows
    (for/first ([i (in-range m)]
                [j (in-range (+ i 1) m)]
                #:when (<= (count-set-bits (row-or (list-ref grid i) (list-ref grid j))) n/2))
      (list i j)
      #:else
      ;; If no single row or pair of rows is good, return an empty list
      (list))))