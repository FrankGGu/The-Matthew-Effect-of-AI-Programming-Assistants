(define (find-peaks mountains)
  (let* ([n (length mountains)])
    (if (< n 3)
        '()
        (let loop ([idx 1]
                   [prev (car mountains)]
                   [curr (cadr mountains)]
                   [rest (cddr mountains)]
                   [result '()])
          (if (null? rest)
              (reverse result)
              (let ([next (car rest)])
                (if (and (> curr prev) (> curr next))
                    (loop (+ idx 1) curr next (cdr rest) (cons idx result))
                    (loop (+ idx 1) curr next (cdr rest) result))))))))