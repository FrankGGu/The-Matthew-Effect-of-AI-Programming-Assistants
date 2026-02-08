(define (make-great s)
  (let loop ((chars (string->list s))
             (stack '()))
    (cond
      ((empty? chars)
       (list->string (reverse stack)))
      (else
       (let ((current-char (car chars)))
         (if (and (not (empty? stack))
                  (let ((top-char (car stack)))
                    (and (char-ci=? current-char top-char)
                         (not (char=? current-char top-char)))))
             (loop (cdr chars) (cdr stack))
             (loop (cdr chars) (cons current-char stack))))))))