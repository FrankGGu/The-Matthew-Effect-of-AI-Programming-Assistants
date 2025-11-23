(define (kth-smallest-path destination k)
  (define (combinations n k)
    (cond
      [(or (zero? k) (= n k)) 1]
      [(< n k) 0]
      [else (+ (combinations (- n 1) (- k 1)) (combinations (- n 1) k))]))

  (define (solve row col k path)
    (cond
      [(= row 0) (string-append path (make-string col #\H))]
      [(= col 0) (string-append path (make-string row #\V))]
      [else
       (let ((horizontal-combinations (combinations (+ row (- col 1)) row)))
         (if (<= k horizontal-combinations)
             (solve row (- col 1) k (string-append path "H"))
             (solve (- row 1) col (- k horizontal-combinations) (string-append path "V"))))]))

  (solve (car destination) (cadr destination) k ""))