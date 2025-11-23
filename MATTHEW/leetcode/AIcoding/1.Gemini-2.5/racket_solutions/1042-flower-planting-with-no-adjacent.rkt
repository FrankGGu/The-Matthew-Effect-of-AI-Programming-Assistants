(define (flower-planting N paths)
  (define adj (make-vector N '()))

  (for-each (lambda (path)
              (define x (car path))
              (define y (cadr path))
              (define x0 (- x 1))
              (define y0 (- y 1))

              (vector-set! adj x0 (cons y0 (vector-ref adj x0)))
              (vector-set! adj y0 (cons x0 (vector-ref adj y0))))
            paths)

  (define result (make-vector N 0))

  (for ([i (in-range N)])
    (define neighbors (vector-ref adj i))
    (define used-flowers-bool (make-vector 5 #f))

    (for-each (lambda (neighbor-idx)
                (define neighbor-flower (vector-ref result neighbor-idx))
                (when (> neighbor-flower 0)
                  (vector-set! used-flowers-bool neighbor-flower #t)))
              neighbors)

    (for ([flower-type (in-range 1 5)])
      (unless (vector-ref used-flowers-bool flower-type)
        (vector-set! result i flower-type)
        (break)))
    )

  (vector->list result))