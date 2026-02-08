(define (reverse-parentheses s)
  (let loop ([s s] [stack '()] [current ""])
    (cond
      [(string=? s "") 
       (if (null? stack) 
           current 
           (loop (car stack) (cdr stack) (string-append (reverse-string current) "")))]
      [(char=? (string-ref s 0) #\() 
       (loop (substring s 1) (cons current stack) "")]
      [(char=? (string-ref s 0) #\)) 
       (loop (substring s 1) (cdr stack) (string-append (car stack) (reverse-string current)))]
      [else 
       (loop (substring s 1) stack (string-append current (substring s 0 1)))])))

(define (reverse-string s)
  (list->string (reverse (string->list s))))