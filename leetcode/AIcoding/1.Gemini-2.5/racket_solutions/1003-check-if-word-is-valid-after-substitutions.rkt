(define (isValid s)
  (let loop ((chars (string->list s))
             (stack '()))
    (cond
      ((null? chars) (null? stack))
      (else
       (let ((char (car chars)))
         (cond
           ((char=? char #\a) (loop (cdr chars) (cons #\a stack)))
           ((char=? char #\b) (loop (cdr chars) (cons #\b stack)))
           ((char=? char #\c)
            (if (and (not (null? stack))
                     (char=? (car stack) #\b)
                     (not (null? (cdr stack)))
                     (char=? (cadr stack) #\a))
                (loop (cdr chars) (cddr stack))
                #f))
           (else #f)))))))