(define (find-occurrences arr target)
  (define (helper arr target acc)
    (cond
      [(empty? arr) acc]
      [(= (car arr) target) (helper (cdr arr) target (cons (length acc) acc))]
      [else (helper (cdr arr) target acc)]))
  (reverse (helper arr target '())))