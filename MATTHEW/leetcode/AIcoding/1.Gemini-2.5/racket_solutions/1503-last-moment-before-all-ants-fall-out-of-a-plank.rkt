(define (get-last-moment n left right)
  (define max-left-fall-time
    (apply max (cons 0 left)))

  (define max-right-fall-time
    (apply max (cons 0 (map (lambda (pos) (- n pos)) right))))

  (max max-left-fall-time max-right-fall-time))