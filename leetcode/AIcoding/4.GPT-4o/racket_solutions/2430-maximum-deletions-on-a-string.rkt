(define (maximum-deletions s)
  (define (helper s count)
    (if (null? s)
        count
        (let ((first (car s))
              (rest (cdr s)))
          (if (and (not (null? rest)) (equal? first (car rest)))
              (helper (cdr rest) (+ count 1))
              (helper rest count)))))
  (helper (string->list s) 0))

(maximum-deletions "your_input_string")