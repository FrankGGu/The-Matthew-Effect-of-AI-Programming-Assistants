(define (maximum-population years)
  (let* ((population (make-vector 101 0))
         (min-year 1950)
         (max-year 2050))
    (for ([year years])
      (let ([birth (car year)]
            [death (cadr year)])
        (for ([i (- birth min-year) (+ (- death min-year) -1)])
          (vector-set! population i (+ 1 (vector-ref population i))))))
    (let loop ([i 0]
               [max-pop 0]
               [max-year min-year])
      (cond
        [(>= i (vector-length population)) max-year]
        [(> (vector-ref population i) max-pop) (loop (+ i 1) (vector-ref population i) (+ min-year i))]
        [else (loop (+ i 1) max-pop max-year)]))))