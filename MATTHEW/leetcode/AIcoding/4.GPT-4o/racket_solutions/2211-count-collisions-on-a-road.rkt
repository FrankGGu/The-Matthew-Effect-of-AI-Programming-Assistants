(define (count-collisions directions)
  (define (helper lst count)
    (cond
      ((null? lst) count)
      ((and (eq? (car lst) #\L) (or (null? (cdr lst)) (eq? (cadr lst) #\L)))
       (helper (cdr lst) count))
      ((and (eq? (car lst) #\R) (or (null? (cdr lst)) (eq? (cadr lst) #\R)))
       (helper (cdr lst) count))
      ((and (eq? (car lst) #\S) (or (null? (cdr lst)) (eq? (cadr lst) #\S)))
       (helper (cdr lst) count))
      (else (helper (cdr lst) (+ count 1)))))

  (helper (string->list directions) 0))