(define random-flip-matrix%
  (class object%
    (super-new)
    (init-field m n)
    (define total (* m n))
    (define hash (make-hash))

    (define/public (flip)
      (define r (random total))
      (define x (hash-ref hash r r))
      (hash-set! hash r (hash-ref hash (sub1 total) (sub1 total)))
      (set! total (sub1 total))
      (list (quotient x n) (remainder x n)))

    (define/public (reset)
      (set! total (* m n))
      (set! hash (make-hash)))))