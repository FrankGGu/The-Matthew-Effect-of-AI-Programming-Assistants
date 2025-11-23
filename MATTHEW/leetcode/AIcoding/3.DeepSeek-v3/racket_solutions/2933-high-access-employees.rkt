(define/contract (high-access-employees access-times)
  (-> (listof (listof any)) (listof string?))
  (define (time->minutes time)
    (let ([hours (string->number (substring time 0 2))]
          [minutes (string->number (substring time 2 4))])
      (+ (* hours 60) minutes)))

  (define (process-employee times)
    (let ([sorted (sort (map time->minutes times) <)])
      (let loop ([lst sorted] [res #f])
        (if (< (length lst) 3)
            res
            (let ([diff (- (list-ref lst 2) (first lst))])
              (if (<= diff 59)
                  #t
                  (loop (rest lst) res)))))))

  (let ([ht (make-hash)])
    (for ([access access-times])
      (let ([name (first access)]
            [time (second access)])
        (hash-update! ht name (lambda (v) (cons time v)) '())))
    (for/list ([(name times) (in-hash ht)]
               #:when (process-employee times)
               name)))