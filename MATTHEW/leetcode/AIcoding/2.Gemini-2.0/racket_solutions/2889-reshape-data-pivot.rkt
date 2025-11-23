(define (pivot data pivot-col value-col)
  (let* ((index-col (list-ref (car data) 0))
         (pivot-col-idx (list-index (car data) pivot-col))
         (value-col-idx (list-index (car data) value-col))
         (index-col-idx 0)
         (index-values (remove-duplicates (map (lambda (row) (list-ref row index-col-idx)) (cdr data))))
         (pivot-values (remove-duplicates (map (lambda (row) (list-ref row pivot-col-idx)) (cdr data))))
         (result-header (cons index-col (sort pivot-values string<?)))
         (result-rows
          (map
           (lambda (index-val)
             (let ((row-data (list index-val)))
               (for ((pivot-val (in-list (sort pivot-values string<?)))))
                 (let ((matching-rows
                        (filter
                         (lambda (row)
                           (and (equal? (list-ref row index-col-idx) index-val)
                                (equal? (list-ref row pivot-col-idx) pivot-val)))
                         (cdr data))))
                   (cond
                     [(empty? matching-rows)
                      (set! row-data (append row-data (list #null)))]
                     [else
                      (set! row-data (append row-data (list (list-ref (car matching-rows) value-col-idx))))]))))
               row-data))
           index-values)))
    (cons result-header result-rows)))

(define (list-index lst val)
  (let loop ((i 0) (l lst))
    (cond
      [(empty? l) #f]
      [(equal? (car l) val) i]
      [else (loop (+ i 1) (cdr l))])))