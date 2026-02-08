(define (num-different-integers word)
  (define (extract-integers s)
    (let loop ((s s) (current "")) 
      (cond
        ((null? s) (if (string=? current "") '() (list (string->number current))))
        ((char-numeric? (car s)) 
         (loop (cdr s) (string-append current (string (car s)))))
        (else 
         (if (string=? current "") 
             (loop (cdr s) current) 
             (cons (string->number current) (loop (cdr s) "")))))))
  (let ((integers (remove-duplicates (extract-integers (string->list word)))))
    (length (filter (lambda (x) (not (zero? x))) integers))))