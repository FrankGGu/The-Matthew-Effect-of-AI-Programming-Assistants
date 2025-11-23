(define (valid-parentheses s)
  (let loop ([chars (string->list s)] [stack '()])
    (cond
      [(empty? chars) (empty? stack)]
      [(char=? (car chars) #\() (loop (cdr chars) (cons #\( stack))]
      [(char=? (car chars) #\[) (loop (cdr chars) (cons #\[ stack))]
      [(char=? (car chars) #\{) (loop (cdr chars) (cons #\{ stack))]
      [(char=? (car chars) #\)) (and (not (empty? stack)) (char=? (car stack) #\() (loop (cdr chars) (cdr stack)))]
      [(char=? (car chars) #\]) (and (not (empty? stack)) (char=? (car stack) #\[) (loop (cdr chars) (cdr stack)))]
      [(char=? (car chars) #\}) (and (not (empty? stack)) (char=? (car stack) #\{) (loop (cdr chars) (cdr stack)))]
      [else #f])))