(define my-hash-set%
  (class object%
    (super-new)
    (init-field)
    (define data (make-hash))

    (define/public (add key)
      (hash-set! data key #t))

    (define/public (remove key)
      (hash-remove! data key))

    (define/public (contains key)
      (hash-has-key? data key))))