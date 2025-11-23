(define randomized-set%
  (class object%
    (super-new)
    (init-field)
    (define h (make-hash))
    (define lst '())

    (define/public (insert val)
      (if (hash-has-key? h val)
          #f
          (begin
            (hash-set! h val (length lst))
            (set! lst (append lst (list val)))
            #t)))

    (define/public (remove val)
      (if (hash-has-key? h val)
          (let* ([idx (hash-ref h val)]
                 [last-val (last lst)])
            (hash-set! h last-val idx)
            (hash-remove! h val)
            (list-set! lst idx last-val)
            (set! lst (take lst (sub1 (length lst))))
            #t)
          #f))

    (define/public (get-random)
      (list-ref lst (random (length lst)))))