(define (balancedStringSplit s)
  (define (helper s count)
    (cond
      ((null? s) count)
      ((equal? (car s) #\L) (helper (cdr s) (+ count 1)))
      ((equal? (car s) #\R) (helper (cdr s) (- count 1)))
      ((= count 0) (helper (cdr s) 1))
      (else (helper (cdr s) count))))
  (helper (string->list s) 0))

(define (balancedStringSplitMain s)
  (define count (balancedStringSplit s))
  (if (= count 0) 1 0))

(balancedStringSplitMain "RLRRLLRLRL")