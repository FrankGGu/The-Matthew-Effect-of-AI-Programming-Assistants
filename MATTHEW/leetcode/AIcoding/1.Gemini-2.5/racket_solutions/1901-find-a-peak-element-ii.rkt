(define (find-peak-element-ii matrix)
  (define num-rows (length matrix))
  (define num-cols (length (car matrix)))

  (define (find-max-in-row row-index)
    (let* ((row (list-ref matrix row-index))
           (max-val (car row))
           (max-col 0))
      (for ([val row]
            [col (in-range num-cols)]
            #:when (> val max-val))
        (set! max-val val)
        (set! max-col col))
      (list max-val max-col)))

  (define (binary-search low high)
    (let* ((mid (+ low (quotient (- high low) 2)))
           (max-info (find-max-in-row mid))
           (max-val (car max-info))
           (max-col (cadr max-info)))

      (if (and (> mid 0)
               (> (list-ref (list-ref matrix (- mid 1)) max-col) max-val))
          (binary-search low (- mid 1))
          (if (and (< mid (- num-rows 1))
                   (> (list-ref (list-ref matrix (+ mid 1)) max-col) max-val))
              (binary-search (+ mid 1) high)
              (list mid max-col)))))

  (binary-search 0 (- num-rows 1)))