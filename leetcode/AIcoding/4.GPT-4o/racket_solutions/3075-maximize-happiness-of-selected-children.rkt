(define (maximize-happiness arr)
  (define (helper index selected)
    (if (= index (length arr))
        (if (= selected 0) 0
            (apply + (take arr selected)))
        (max (helper (+ index 1) selected)
             (if (< selected (length arr))
                 (+ (list-ref arr index) (helper (+ index 1) (+ selected 1)))
                 (helper (+ index 1) selected)))))
  (helper 0 0))

(define (maxHappiness arr)
  (maximize-happiness arr))