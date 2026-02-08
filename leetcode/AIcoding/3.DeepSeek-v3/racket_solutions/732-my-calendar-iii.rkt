(define my-calendar-three%
  (class object%
    (super-new)
    (init-field)
    (define events (make-hash))

    (define/public (book start end)
      (hash-update! events start (lambda (v) (add1 v)) 0)
      (hash-update! events end (lambda (v) (sub1 v)) 0)
      (let loop ([lst (sort (hash-keys events) <)]
                 [active 0]
                 [max-active 0])
        (if (null? lst)
            max-active
            (let* ([time (car lst)]
                   [count (hash-ref events time)]
                   [new-active (+ active count)])
              (loop (cdr lst) new-active (max max-active new-active))))))))