(define/contract (delete-duplicates head)
  (-> (or/c null? list?) (or/c null? list?))
  (cond
    [(null? head) null]
    [(null? (cdr head)) head]
    [(= (car head) (car (cdr head)))
     (delete-duplicates (cdr head))]
    [else (cons (car head) (delete-duplicates (cdr head)))]))