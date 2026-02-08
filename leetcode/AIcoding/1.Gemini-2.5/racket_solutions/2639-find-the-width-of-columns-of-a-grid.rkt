(define (find-column-widths grid)
  (if (empty? grid)
      '()
      (let* ((num-columns (length (car grid)))
             (initial-max-widths (build-list num-columns (lambda (x) 0))))
        (let loop ((rows grid) (current-max-widths initial-max-widths))
          (if (empty? rows)
              current-max-widths
              (let* ((row (car rows))
                     (updated-max-widths
                      (map (lambda (num max-w)
                             (max max-w (string-length (number->string num))))
                           row
                           current-max-widths)))
                (loop (cdr rows) updated-max-widths)))))))