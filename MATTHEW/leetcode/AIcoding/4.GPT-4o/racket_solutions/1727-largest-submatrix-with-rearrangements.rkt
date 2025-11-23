(define (largest-submatrix matrix)
  (define (max-in-list lst) (apply max lst))
  (define (calculate-area row)
    (define (get-heights mat)
      (for/list ([i (in-range (length mat))])
        (if (= (vector-ref mat i 0) 0)
            0
            (if (= i 0)
                (vector-ref mat i 0)
                (+ (vector-ref mat i 0) (vector-ref mat (sub1 i) 0)))))
    (define heights (get-heights row))
    (define sorted-heights (sort heights >))
    (for/fold ([max-area 0]) ([i (in-range (length sorted-heights))])
      (define area (* (vector-ref sorted-heights i) (add1 i)))
      (max max-area area)))

  (define (transpose mat)
    (for*/list ([j (in-range (length (vector-ref mat 0)))])
      (for/list ([i (in-range (length mat))])
        (vector-ref (vector-ref mat i) j))))

  (define (compute-max-area mat)
    (for/fold ([max-area 0]) ([row (in-range (length mat))])
      (define area (calculate-area (vector-ref mat row)))
      (max max-area area)))

  (define num-rows (length matrix))
  (define num-cols (length (vector-ref matrix 0)))
  (define heights (make-vector num-rows (make-vector num-cols 0)))

  (for ([j (in-range num-cols)])
    (for ([i (in-range num-rows)])
      (if (= (vector-ref matrix i j) 1)
          (vector-set! (vector-ref heights i) j
                       (if (= i 0) 1 (+ 1 (vector-ref (vector-ref heights (sub1 i)) j)))))))

  (compute-max-area heights))