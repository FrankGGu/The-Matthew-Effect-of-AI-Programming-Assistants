(define (remove-outer-parentheses s)
  (let loop ([chars (string->list s)]
             [balance 0]
             [result '()])
    (cond
      [(empty? chars) (list->string (reverse result))]
      [(char=? (car chars) #\()
       (if (> balance 0)
           (loop (cdr chars) (+ balance 1) (cons (car chars) result))
           (loop (cdr chars) (+ balance 1) result))]
      [(char=? (car chars) #\))
       (if (> balance 1)
           (loop (cdr chars) (- balance 1) (cons (car chars) result))
           (loop (cdr chars) (- balance 1) result))]
      [else (loop (cdr chars) balance result)])))