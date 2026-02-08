(define (num-special-equiv-groups strs)
  (define (normalize str)
    (let loop ([s (string->list str)] [even '()] [odd '()])
      (cond
        [(empty? s)
         (list->string (append (sort even char<?) (sort odd char<?)))]
        [(empty? (cdr s))
         (list->string (append (sort (cons (car s) even) char<?) (sort odd char<?)))]
        [else
         (loop (cddr s) (cons (car s) even) (cons (cadr s) odd))])))

  (define groups (make-hash))
  (for-each (lambda (str)
              (hash-set! groups (normalize str) #t))
            strs)
  (hash-count groups))