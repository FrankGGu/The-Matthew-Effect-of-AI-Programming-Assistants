(define (repeated-n-element nums)
  (define (helper lst seen)
    (cond
      ((null? lst) '())
      ((member (car lst) seen) (car lst))
      (else (helper (cdr lst) (cons (car lst) seen)))))
  (helper nums '()))

(repeated-n-element nums)