(define SimpleMap
  (class object%
    (super-new)
    (define public map (hash))

    (define/public (insert key value)
      (hash-set! map key value))

    (define/public (get key)
      (hash-ref map key '()))

    (define/public (remove key)
      (hash-remove! map key))

    (define/public (contains key)
      (hash-has? map key))

    (define/public (keys)
      (hash-keys map))

    (define/public (values)
      (hash-values map))

    (define/public (clear)
      (hash-clear! map))

    (define/public (size)
      (hash-count map))))