(define (minimize-string-length s)
  (define (helper prev chars)
    (if (null? chars)
        0
        (let ((current (car chars)))
          (if (equal? current prev)
              (helper prev (cdr chars))
              (+ 1 (helper current (cdr chars)))))))
  (if (null? s)
      0
      (helper (car s) (cdr s))))