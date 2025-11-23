(define (maximum-number-of-alloys n k budget costs stock)
  (define (possible? num)
    (let loop ((i 0) (total-cost 0))
      (cond
        ((= i n) (<= total-cost budget))
        (else
         (let ((needed-material (max 0 (- (* num (list-ref costs i)) (list-ref stock i)))))
           (if (<= total-cost budget)
               (loop (+ i 1) (+ total-cost (* needed-material (list-ref (list-ref k 0) i))))
               #f))))))

  (define (binary-search low high)
    (cond
      ((> low high) high)
      (else
       (let ((mid (floor (/ (+ low high) 2))))
         (if (possible? mid)
             (binary-search (+ mid 1) high)
             (binary-search low (- mid 1)))))))

  (binary-search 0 (+ budget (apply max stock))))