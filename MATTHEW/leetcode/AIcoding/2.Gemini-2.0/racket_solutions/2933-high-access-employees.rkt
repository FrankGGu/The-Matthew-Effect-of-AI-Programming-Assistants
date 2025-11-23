(define (high-access-employees access-times)
  (define (parse-time time-str)
    (let ([hours (string->number (substring time-str 0 2))]
          [minutes (string->number (substring time-str 2 4))])
      (+ (* hours 60) minutes)))

  (define employee-access-times (make-hash))
  (for ([access-time access-times])
    (let ([employee-id (car access-time)]
          [time-str (cadr access-time)])
      (hash-update! employee-access-times employee-id
                     (lambda (existing-times)
                       (cons (parse-time time-str) existing-times))
                     '())))

  (define high-access-employees '())
  (hash-for-each employee-access-times
                 (lambda (employee-id times)
                   (let ([sorted-times (sort times <)])
                     (cond
                       [(< (length sorted-times) 3) #f]
                       [else
                        (let loop ([times sorted-times])
                          (cond
                            [(null? (cdr (cdr times))) #f]
                            [else
                             (if (<= (- (car (cdr (cdr times))) (car times)) 59)
                                 (begin (set! high-access-employees (cons employee-id high-access-employees)) #t)
                                 (loop (cdr times)))]))])))))
  (remove-duplicates high-access-employees))