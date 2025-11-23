(define randomized-collection%
  (class object%
    (super-new)
    (init-field)
    (define h (make-hash))
    (define lst '())

    (define/public (insert val)
      (let ([exists (hash-has-key? h val)])
        (hash-update! h val (lambda (v) (cons (length lst) v)) (list))
        (set! lst (cons val lst))
        (not exists))

    (define/public (remove val)
      (if (hash-has-key? h val)
          (let* ([indices (hash-ref h val)]
                 [index (car indices)]
                 [last-index (sub1 (length lst))]
                 [last-val (list-ref lst last-index)])
            (hash-update! h last-val
                          (lambda (v)
                            (cons index (remove last-index v))))
            (list-set! lst index last-val)
            (set! lst (take lst last-index))
            (if (null? (cdr indices))
                (hash-remove! h val)
                (hash-set! h val (cdr indices)))
            #t)
          #f))

    (define/public (get-random)
      (list-ref lst (random (length lst))))))