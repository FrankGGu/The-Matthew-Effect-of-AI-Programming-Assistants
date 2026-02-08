(define (prefixesDivBy5 A)
  (define (helper lst acc)
    (if (null? lst)
        acc
        (let* ((new-val (+ (* acc 2) (car lst)))
               (result (cons (= (modulo new-val 5) 0) (helper (cdr lst) new-val))))
          result)))
  (helper A 0))