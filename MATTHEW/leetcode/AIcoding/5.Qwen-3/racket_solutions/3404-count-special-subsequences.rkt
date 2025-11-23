(define (count-special-subsequences s)
  (let ((a 0) (ab 0) (abc 0))
    (for-each
     (lambda (c)
       (cond
         [(char=? c #\a) (set! a (+ a 1))]
         [(char=? c #\b) (set! ab (+ ab a))]
         [(char=? c #\c) (set! abc (+ abc ab))]))
     (string->list s))
    abc))