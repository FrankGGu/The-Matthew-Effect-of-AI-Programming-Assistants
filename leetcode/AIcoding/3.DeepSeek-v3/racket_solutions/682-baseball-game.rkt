(define (cal-points ops)
  (let loop ([ops ops] [stack '()] [sum 0])
    (if (null? ops)
        sum
        (let ([op (car ops)])
          (cond
            [(string=? op "+") 
             (let ([score (+ (car stack) (cadr stack))])
               (loop (cdr ops) (cons score stack) (+ sum score)))]
            [(string=? op "D")
             (let ([score (* 2 (car stack))])
               (loop (cdr ops) (cons score stack) (+ sum score)))]
            [(string=? op "C")
             (loop (cdr ops) (cdr stack) (- sum (car stack)))]
            [else
             (let ([score (string->number op)])
               (loop (cdr ops) (cons score stack) (+ sum score)))])))))