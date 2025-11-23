(define (countOccurrences arr target)
  (define (helper lst count)
    (cond
      ((null? lst) count)
      ((equal? (car lst) target) (helper (cdr lst) (+ count 1)))
      (else (helper (cdr lst) count))))
  (helper arr 0))