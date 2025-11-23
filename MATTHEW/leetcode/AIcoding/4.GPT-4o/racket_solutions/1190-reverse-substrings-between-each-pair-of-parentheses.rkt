(define (reverse-substrings s)
  (define (helper s)
    (define stack '())
    (define current "")
    (for ([char (in-string s)])
      (cond
        [(equal? char #\() 
         (set! stack (cons current stack))
         (set! current "")]
        [(equal? char #\)) 
         (set! current (apply string-append (reverse (cons current stack))))
         (set! stack '')]
        [else 
         (set! current (string-append current (string char)))])
      )
    current)
  (helper s))

(reverse-substrings "a(bcdefghijkl(mno)p)q")