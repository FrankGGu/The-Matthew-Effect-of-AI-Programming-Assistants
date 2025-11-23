(define (alert-using-same-key-card keyTimes)
  (define employee-accesses (make-hash))

  (define (time-string->minutes time-str)
    (let* ([parts (string-split time-str ":")]
           [hours (string->number (car parts))]
           [minutes (string->number (cadr parts))])
      (+ (* hours 60) minutes)))

  (for-each (lambda (entry)
              (let* ([name (car entry)]
                     [time-str (cadr entry)]
                     [minutes (time-string->minutes time-str)])
                (hash-set! employee-accesses
                           name
                           (cons minutes (hash-ref employee-accesses name '())))))
            keyTimes)

  (define alert-employees (make-hash))

  (for-each (lambda (name)
              (let* ([times (sort (hash-ref employee-accesses name) <)]
                     [n (length times)])
                (when (>= n 3)
                  (let check-triplets ([i 0])
                    (when (< i (- n 2))
                      (let ([t1 (list-ref times i)]
                            [t3 (list-ref times (+ i 2))])
                        (if (<= (- t3 t1) 60)
                            (hash-set! alert-employees name #t)
                            (check-triplets (+ i 1)))))))))
            (hash-keys employee-accesses))

  (sort (hash-keys alert-employees) string<?))