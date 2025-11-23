(define (is-valid s)
  (let loop ([s s] [stack '()])
    (cond
      [(string=? s "") (null? stack)]
      [(and (>= (string-length s) 3) 
            (string=? (substring s 0 3) "abc"))
       (loop (substring s 3) stack)]
      [(not (null? stack))
       (let ([c (string-ref s 0)])
         (if (char=? c #\a)
             (loop (substring s 1) (cons c stack))
             (loop (substring s 1) (cdr stack))))]
      [else #f])))