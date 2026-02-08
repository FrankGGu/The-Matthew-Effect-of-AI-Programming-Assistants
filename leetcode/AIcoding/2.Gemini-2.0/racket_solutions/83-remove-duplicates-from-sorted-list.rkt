(define (delete-duplicates head)
  (cond
    [(null? head) head]
    [else
     (let loop ([current head])
       (cond
         [(null? (cdr current)) head]
         [(= (car current) (car (cdr current)))
          (set-cdr! current (cdr (cdr current)))
          (loop current)]
         [else
          (loop (cdr current))]))
     head]))