(define ordered-stream%
  (class object%
    (super-new)
    (init-field n)
    (field [ptr 1]
           [store (make-hash)])

    (define/public (insert id-key value)
      (hash-set! store id-key value)
      (let loop ([result null]
                 [current ptr])
        (if (hash-has-key? store current)
            (loop (cons (hash-ref store current) result) (add1 current))
            (begin
              (set! ptr current)
              (reverse result))))))