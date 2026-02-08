(define (equal-pairs grid)
  (define n (length grid))

  (define (get-column grid col-idx)
    (define (iter row-idx acc)
      (if (= row-idx n)
          (reverse acc)
          (iter (+ row-idx 1) (cons (list-ref (list-ref grid row-idx) col-idx) acc))))
    (iter 0 '()))

  (define (row-loop ri current-total-pairs)
    (if (= ri n)
        current-total-pairs
        (let* ((current-row (list-ref grid ri))
               (pairs-from-current-row (col-loop 0 current-row 0)))
          (row-loop (+ ri 1) (+ current-total-pairs pairs-from-current-row)))))

  (define (col-loop cj current-row pairs-for-this-row)
    (if (= cj n)
        pairs-for-this-row
        (let* ((current-column (get-column grid cj))
               (new-pairs-for-this-row (if (equal? current-row current-column)
                                           (+ pairs-for-this-row 1)
                                           pairs-for-this-row)))
          (col-loop (+ cj 1) current-row new-pairs-for-this-row))))

  (row-loop 0 0))