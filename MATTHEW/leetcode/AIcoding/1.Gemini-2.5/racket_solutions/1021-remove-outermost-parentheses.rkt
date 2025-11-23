(define (remove-outermost-parentheses s)
  (let loop ((chars (string->list s))
             (balance 0)
             (result-chars '()))
    (if (null? chars)
        (list->string (reverse result-chars))
        (let ((char (car chars)))
          (cond
            ((char=? char #\()
             (let ((new-balance (+ balance 1)))
               (loop (cdr chars)
                     new-balance
                     (if (> balance 0) (cons char result-chars) result-chars))))
            ((char=? char #\))
             (let ((new-balance (- balance 1)))
               (loop (cdr chars)
                     new-balance
                     (if (> new-balance 0) (cons char result-chars) result-chars))))
            (else
             (loop (cdr chars) balance result-chars)))))))