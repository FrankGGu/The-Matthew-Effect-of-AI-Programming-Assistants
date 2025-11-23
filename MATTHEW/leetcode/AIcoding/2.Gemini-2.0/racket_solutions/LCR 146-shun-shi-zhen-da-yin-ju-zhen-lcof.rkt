(define (spiral-order matrix)
  (define (spiral-helper matrix row-start row-end col-start col-end acc)
    (cond
      [(or (> row-start row-end) (> col-start col-end)) acc]
      [else
       (let* ([top-row (list->vector (vector->list (vector-ref matrix row-start))))
              (for ([i (in-range col-start (add1 col-end))])
                (set! acc (append acc (list (vector-ref top-row i))))))
       (let ([right-col (for/list ([i (in-range (add1 row-start) row-end)])
                           (vector-ref (vector-ref matrix i) col-end))])
         (set! acc (append acc right-col)))
       (cond
         [(<= row-start row-end)
          (cond
            [(<= col-start col-end)
             (let* ([bottom-row (list->vector (vector->list (vector-ref matrix row-end))))
                    (for ([i (in-range (sub1 col-end) (sub1 col-start) -1)])
                      (set! acc (append acc (list (vector-ref bottom-row i))))))
             (let ([left-col (for/list ([i (in-range (sub1 row-end) (add1 row-start) -1)])
                                (vector-ref (vector-ref matrix i) col-start))])
               (set! acc (append acc left-col)))])])])
       (spiral-helper matrix (add1 row-start) (sub1 row-end) (add1 col-start) (sub1 col-end) acc)]))

  (let ([rows (vector-length matrix)]
        [cols (vector-length (vector-ref matrix 0))])
    (spiral-helper matrix 0 (sub1 rows) 0 (sub1 cols) '())))