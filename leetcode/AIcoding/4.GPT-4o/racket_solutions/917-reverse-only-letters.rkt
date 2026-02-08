(define (reverseOnlyLetters s)
  (define letters (filter char-alphabetic (string->list s)))
  (define reversed-letters (reverse letters))
  (define (build-result lst r)
    (cond
      ((null? lst) '())
      ((char-alphabetic (car lst)) 
       (cons (car r) (build-result (cdr lst) (cdr r)))
       )
      (else 
       (cons (car lst) (build-result (cdr lst) r))))
    )
  (list->string (build-result (string->list s) reversed-letters)))

(define (reverseOnlyLetters-main)
  (reverseOnlyLetters "ab-cd")) ; Example usage