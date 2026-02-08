(define rle-iterator%
  (class object%
    (super-new)
    (init-field encoding)

    (define idx 0)
    (define current-count (if (null? encoding) 0 (car encoding)))
    (define current-value (if (null? encoding) 0 (cadr encoding)))

    (define/public (next n)
      (let loop ([remaining n])
        (if (<= remaining 0)
            current-value
            (if (>= idx (length encoding))
                -1
                (if (>= remaining current-count)
                    (begin
                      (set! remaining (- remaining current-count))
                      (set! idx (+ idx 2))
                      (if (>= idx (length encoding))
                          -1
                          (begin
                            (set! current-count (list-ref encoding idx))
                            (set! current-value (list-ref encoding (+ idx 1)))
                            (loop remaining)))
                    (begin
                      (set! current-count (- current-count remaining))
                      current-value)))))))