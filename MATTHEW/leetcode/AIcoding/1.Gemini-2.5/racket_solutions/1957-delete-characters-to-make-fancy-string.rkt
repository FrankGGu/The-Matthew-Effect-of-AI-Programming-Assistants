(define (make-fancy-string s)
  (let loop ((chars (string->list s)) ; Remaining input characters
             (result '())             ; Built characters in reverse order
             (last-char #f)           ; Last character added to result
             (second-last-char #f))   ; Second-to-last character added to result
    (cond
      ((empty? chars)
       (list->string (reverse result)))
      (else
       (let ((current-char (car chars)))
         (if (and last-char second-last-char
                  (char=? current-char last-char)
                  (char=? current-char second-last-char))
             ;; Skip current-char if it would form three consecutive identical characters
             (loop (cdr chars) result last-char second-last-char)
             ;; Add current-char to the result
             (loop (cdr chars) (cons current-char result) current-char last-char)))))))