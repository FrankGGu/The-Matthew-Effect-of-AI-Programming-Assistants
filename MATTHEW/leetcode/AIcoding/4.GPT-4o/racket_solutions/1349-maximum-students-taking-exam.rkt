(define (maxStudents seats)
  (define rows (length seats))
  (define cols (length (first seats)))

  (define (valid? row bitmask)
    (for*/list ([c (in-range cols)])
      (if (bitwise-and (bitwise-shift-left 1 c) bitmask)
          (if (or (zero? row) 
                  (bitwise-and (bitwise-shift-left 1 (- c 1)) (list-ref seats (- row 1)))
                  (bitwise-and (bitwise-shift-left 1 (+ c 1)) (list-ref seats (- row 1))))
              #f
              #t)
          #t)))

  (define (dp row bitmask)
    (if (= row rows)
        0
        (let loop ([mask 0])
          (if (= mask (expt 2 cols))
              (dp (+ row 1) 0)
              (let* ([current-seats (if (valid? row mask) mask 0)]
                     [next-row (dp (+ row 1) 0)]
                     [count-seats (if (> current-seats 0)
                                      (count (lambda (c) (= (bitwise-and current-seats (bitwise-shift-left 1 c)) 0)) (in-range cols))
                                      0)])
                (max (if (> current-seats 0) (+ count-seats next-row) next-row)
                     (loop (+ mask 1))))))))

  (dp 0 0))