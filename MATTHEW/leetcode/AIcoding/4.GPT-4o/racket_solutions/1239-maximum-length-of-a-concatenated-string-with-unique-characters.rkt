(define (maxLength arr)
  (define (is-unique? str)
    (let loop ((seen '())
               (chars (string->list str)))
      (cond
        ((null? chars) #t)
        ((memv (car chars) seen) #f)
        (else (loop (cons (car chars) seen) (cdr chars))))))

  (define (dfs index current)
    (if (>= index (length arr))
        (if (is-unique? current) (string-length current) 0)
        (let ((take (dfs (+ index 1) (string-append current (list-ref arr index))))
              (skip (dfs (+ index 1) current)))
          (max take skip))))

  (dfs 0 ""))

(maxLength '("un", "iq", "ue"))