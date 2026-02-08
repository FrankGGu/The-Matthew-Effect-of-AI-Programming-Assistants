(define (find-diagonal-order matrix)
  (define m (length matrix))
  (define n (length (car matrix)))
  (define result '())
  (define up? #t)
  (define row 0)
  (define col 0)

  (define (valid-index? r c)
    (and (>= r 0) (< r m) (>= c 0) (< c n)))

  (for ([i (in-range (* m n))])
    (set! result (append result (list (list-ref (list-ref matrix row) col))))

    (if up?
        (begin
          (if (and (valid-index? (- row 1) (+ col 1)))
              (begin
                (set! row (- row 1))
                (set! col (+ col 1)))
              (if (valid-index? row (+ col 1))
                  (set! col (+ col 1))
                  (set! row (+ row 1))
                  )
              (set! up? #f)))
        (begin
          (if (and (valid-index? (+ row 1) (- col 1)))
              (begin
                (set! row (+ row 1))
                (set! col (- col 1)))
              (if (valid-index? (+ row 1) col)
                  (set! row (+ row 1))
                  (set! col (+ col 1)))
              (set! up? #t)))))

  result)