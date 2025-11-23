(define/contract (reverse-book-list head)
  (-> (or/c null? list?) (or/c null? list?))
  (let loop ([prev null]
             [curr head])
    (if (null? curr)
        prev
        (let ([next (cdr curr)])
          (loop (cons (car curr) prev) next)))))