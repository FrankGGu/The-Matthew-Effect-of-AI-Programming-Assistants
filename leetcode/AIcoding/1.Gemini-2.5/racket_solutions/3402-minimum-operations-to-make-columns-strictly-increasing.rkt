(define (minimum-operations-to-make-columns-strictly-increasing grid)
  (let* ([m (length grid)]
         [n (length (car grid))])
    (if (= m 1)
        0
        (let loop ([col-idx 0] [total-ops 0])
          (if (< col-idx n)
              (let* ([val0 (list-ref (list-ref grid 0) col-idx)]
                     [val1 (list-ref (list-ref grid 1) col-idx)]
                     [col-ops (+ (if (= val0 1) 1 0)
                                 (if (= val1 0) 1 0))])
                (loop (+ col-idx 1) (+ total-ops col-ops)))
              total-ops)))))