(define (getMaxLen nums)
  (define (helper lst pos-neg)
    (if (null? lst)
        0
        (let ((num (car lst)))
          (cond
            ((> num 0) (add1 (helper (cdr lst) (+ pos-neg 1))))
            ((< num 0) (if (zero? pos-neg)
                           (helper (cdr lst) 1)
                           (helper (cdr lst) 0)))
            (else (max (helper (cdr lst) 0) pos-neg))))))

  (helper nums 0))

(getMaxLen '(1 -2 -3 4))