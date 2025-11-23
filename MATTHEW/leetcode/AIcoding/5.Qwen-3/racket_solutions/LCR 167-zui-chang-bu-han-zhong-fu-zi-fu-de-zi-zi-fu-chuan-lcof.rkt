(define (dissolve-technique s)
  (define (helper s res)
    (if (null? s)
        res
        (let ((c (car s)))
          (if (char=? c #\ )
              (helper (cdr s) res)
              (helper (cdr s) (append res (list c)))))))
  (list->string (helper (string->list s) '())))