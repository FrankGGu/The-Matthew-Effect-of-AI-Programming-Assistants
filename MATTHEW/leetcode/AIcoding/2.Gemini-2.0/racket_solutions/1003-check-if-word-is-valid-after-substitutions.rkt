(define (is-valid s)
  (let loop ([s s] [stack '()])
    (cond
      [(string=? s "") (null? stack)]
      [(string-prefix? s "abc") (loop (substring s 3) stack)]
      [(string-prefix? s "a") (loop (substring s 1) (cons "a" stack))]
      [(string-prefix? s "b")
       (cond
         [(null? stack) #f]
         [(string=? (car stack) "a") (loop (substring s 1) (cons "b" (cdr stack)))]
         [else #f])]
      [(string-prefix? s "c")
       (cond
         [(null? stack) #f]
         [(string=? (car stack) "b")
          (cond
            [(null? (cdr stack)) #f]
            [(string=? (cadr stack) "a") (loop (substring s 1) (cddr stack))]
            [else #f])]
         [else #f])]
      [else #f])))