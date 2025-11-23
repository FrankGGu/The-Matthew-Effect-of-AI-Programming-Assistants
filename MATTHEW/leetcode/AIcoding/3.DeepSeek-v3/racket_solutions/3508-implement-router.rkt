(define router%
  (class object%
    (super-new)
    (init-field)
    (define routes (make-hash))

    (define/public (insert path handler)
      (hash-set! routes path handler))

    (define/public (find path)
      (hash-ref routes path (lambda () #f)))

    (define/public (route path)
      (let ([handler (find path)])
        (if handler
            (handler)
            "404 Not Found"))))