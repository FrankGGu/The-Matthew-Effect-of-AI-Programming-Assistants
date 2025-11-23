(define (add-spaces s spaces)
  (string-join
   (let loop ([i 0] [spaces spaces] [res '()])
     (cond
       [(null? spaces) (append (reverse res) (list (substring s i (string-length s))))]
       [else (let ([space (car spaces)])
               (loop (+ 1 space) (cdr spaces) (append (reverse res) (list (substring s i space))) ))]))
   " "))