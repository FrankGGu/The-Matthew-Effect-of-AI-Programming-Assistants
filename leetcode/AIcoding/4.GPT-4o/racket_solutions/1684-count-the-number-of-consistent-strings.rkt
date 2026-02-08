(define (count-consistent-strings allowed string)
  (define allowed-set (string->list allowed))
  (define (consistent? s)
    (for/all ([ch (string->list s)])
      (member ch allowed-set)))
  (define (count-helper strs count)
    (if (null? strs)
        count
        (count-helper (cdr strs) (if (consistent? (car strs)) (+ count 1) count))))
  (count-helper (string->list string) 0))

(define (count-consistent-strings allowed string)
  (count-helper (string->list string) 0))