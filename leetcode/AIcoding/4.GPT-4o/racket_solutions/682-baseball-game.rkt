(define (calPoints ops)
  (define (helper ops acc)
    (cond
      ((null? ops) acc)
      ((string=? (car ops) "C") (helper (cdr ops) (cdr acc)))
      ((string=? (car ops) "D") (helper (cdr ops) (cons (* 2 (car acc)) acc)))
      ((string=? (car ops) "+") (helper (cdr ops) (cons (+ (car acc) (cadr acc)) acc)))
      (else (helper (cdr ops) (cons (string->number (car ops)) acc)))))
  (apply + (reverse (helper ops '())))
)

(calPoints '("5" "-2" "4" "C" "D" "9" "+"))