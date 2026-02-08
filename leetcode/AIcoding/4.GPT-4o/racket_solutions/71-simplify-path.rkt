(define (simplifyPath path)
  (define parts (string-split path "/"))
  (define stack '())
  (for-each (lambda (part)
              (cond
                ((equal? part "") '())
                ((equal? part ".") '())
                ((equal? part "..") (if (not (null? stack)) (set! stack (cdr stack))))
                (else (set! stack (cons part stack)))))
            parts)
  (if (null? stack)
      "/"
      (string-append "/" (string-join (reverse stack) "/"))))