(define (num-special-positions mat)
  (let* ([rows (length mat)]
         [cols (length (car mat))]
         [row-sums (make-vector rows 0)]
         [col-sums (make-vector cols 0)])
    (for* ([i (in-range rows)]
           [j (in-range cols)])
      (when (= (list-ref (list-ref mat i) j) 1)
        (vector-set! row-sums i (+ (vector-ref row-sums i) 1))
        (vector-set! col-sums j (+ (vector-ref col-sums j) 1))))
    (let loop ([i 0] [count 0])
      (if (= i rows)
          count
          (let loop2 ([j 0])
            (if (= j cols)
                (loop (+ i 1) count)
                (if (and (= (list-ref (list-ref mat i) j) 1)
                         (= (vector-ref row-sums i) 1)
                         (= (vector-ref col-sums j) 1))
                    (loop (+ i 1) (+ count 1))
                    (loop2 (+ j 1)))))))))