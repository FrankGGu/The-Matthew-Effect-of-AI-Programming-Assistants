(define (longest-valid-parentheses s)
  (define stack (list))
  (define max-len 0)
  (define last-invalid -1)

  (for ((i (in-range (string-length s))))
    (cond
      [(char=? (string-ref s i) #\()
       (set! stack (cons i stack))]
      [(char=? (string-ref s i) #\))
       (if (null? stack)
           (set! last-invalid i)
           (begin
             (set! stack (cdr stack))
             (if (null? stack)
                 (set! max-len (max max-len (- i last-invalid)))
                 (set! max-len (max max-len (- i (car stack)))))))]))

  max-len)