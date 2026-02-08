(define (select-data records col-idx value)
  (filter (lambda (record)
            (equal? (list-ref record col-idx) value))
          records))