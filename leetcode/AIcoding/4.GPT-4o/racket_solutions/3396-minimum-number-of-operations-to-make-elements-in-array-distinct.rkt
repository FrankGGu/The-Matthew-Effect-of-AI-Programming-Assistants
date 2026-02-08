(define (minOperations A)
  (define (helper lst seen count)
    (cond
      [(null? lst) count]
      [(not (set-member? seen (car lst)))
       (helper (cdr lst) (set-add seen (car lst)) count)]
      [else
       (helper (cdr lst) seen (+ count 1))]))
  (helper (sort A <) (set) 0))