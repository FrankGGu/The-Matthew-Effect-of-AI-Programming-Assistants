(define (calPoints ops)
  (let loop ([ops ops] [stack '()])
    (cond
      [(empty? ops) (apply + stack)]
      [(string=? (car ops) "+") (loop (cdr ops) (cons (+ (car stack) (cadr stack)) stack))]
      [(string=? (car ops) "D") (loop (cdr ops) (cons (* 2 (car stack)) stack))]
      [(string=? (car ops) "C") (loop (cdr ops) (cdr stack))]
      [else (loop (cdr ops) (cons (string->number (car ops)) stack))])))