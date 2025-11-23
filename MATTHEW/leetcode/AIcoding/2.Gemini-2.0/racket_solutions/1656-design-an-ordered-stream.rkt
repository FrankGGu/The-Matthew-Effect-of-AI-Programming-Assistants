(define ordered-stream%
  (class object%
    (init-field size)
    (super-new)

    (define current-index 1)
    (define data (make-hash))

    (define/public (insert idKey value)
      (hash-set! data idKey value)
      (define result '())
      (let loop ()
        (if (hash-has-key? data current-index)
            (begin
              (set! result (append result (list (hash-ref data current-index))))
              (hash-remove! data current-index)
              (set! current-index (+ current-index 1))
              (loop))
            '()))
      result)
    ))