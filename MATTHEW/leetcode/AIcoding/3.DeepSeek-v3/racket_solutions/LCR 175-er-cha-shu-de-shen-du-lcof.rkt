(define (max-depth root)
  (if (null? root)
      0
      (+ 1 (max (max-depth (car (cdr root)))
                (max-depth (car (cdr (cdr root)))))))