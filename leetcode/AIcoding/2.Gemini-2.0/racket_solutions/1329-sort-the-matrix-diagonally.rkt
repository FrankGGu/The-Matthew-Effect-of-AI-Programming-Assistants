(define (diagonal-sort mat)
  (define m (length mat))
  (define n (length (car mat)))
  (define (sort-diagonal row col)
    (define diagonal (list))
    (let loop ((r row) (c col))
      (if (and (< r m) (< c n))
          (begin
            (set! diagonal (cons (list-ref (list-ref mat r) c) diagonal))
            (loop (+ r 1) (+ c 1)))
          (begin
            (set! diagonal (reverse diagonal))
            (let ((sorted-diagonal (sort diagonal <)))
              (let loop2 ((r row) (c col) (sorted-diag sorted-diagonal))
                (if (and (< r m) (< c n))
                    (begin
                      (set! (list-ref (list-ref mat r) c) (car sorted-diag))
                      (loop2 (+ r 1) (+ c 1) (cdr sorted-diag)))
                    #t)))))))

  (for ((i (in-range m)))
    (sort-diagonal i 0))

  (for ((j (in-range 1 n)))
    (sort-diagonal 0 j))

  mat)