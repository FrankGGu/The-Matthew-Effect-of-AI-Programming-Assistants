(define (clear-digits s)
  (let loop ((chars (string->list s))
             (result-stack '())) ; result-stack stores non-digits, most recent at head
    (cond
      ((empty? chars)
       (list->string (reverse result-stack))) ; reverse to get original order
      (else
       (let ((current-char (car chars)))
         (if (char-digit? current-char)
             (loop (cdr chars)
                   (if (empty? result-stack)
                       result-stack ; digit has nothing to remove if stack is empty
                       (cdr result-stack))) ; remove last non-digit (head of stack)
             (loop (cdr chars)
                   (cons current-char result-stack)))))))) ; add non-digit to stack