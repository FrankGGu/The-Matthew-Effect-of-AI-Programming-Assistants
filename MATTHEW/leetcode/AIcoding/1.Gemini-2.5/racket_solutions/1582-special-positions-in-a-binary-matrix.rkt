(define (num-special mat)
  (define m (length mat))
  (define n (length (car mat)))

  (define row-sums (make-vector m 0))
  (define col-sums (make-vector n 0))

  (for ([i (in-range m)])
    (define current-row (list-ref mat i))
    (for ([j (in-range n)])
      (when (= (list-ref current-row j) 1)
        (vector-set! row-sums i (+ (vector-ref row-sums i) 1))
        (vector-set! col-sums j (+ (vector-ref col-sums j) 1)))))

  (define special-count 0)
  (for ([i (in-range m)])
    (define current-row (list-ref mat i))
    (for ([j (in-range n)])
      (when (and (= (list-ref current-row j) 1)
                 (= (vector-ref row-sums i) 1)
                 (= (vector-ref col-sums j) 1))
        (set! special-count (+ special-count 1)))))

  special-count)