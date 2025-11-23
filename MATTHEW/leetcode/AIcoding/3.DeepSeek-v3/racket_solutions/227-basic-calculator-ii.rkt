(define (calculate s)
  (let loop ([i 0] [stack '()] [num 0] [sign #\+])
    (define (apply-op op a b)
      (cond
        [(char=? op #\+) (+ a b)]
        [(char=? op #\-) (- a b)]
        [(char=? op #\*) (* a b)]
        [(char=? op #\/) (quotient a b)]))
    (if (>= i (string-length s))
        (apply + stack)
        (let ([c (string-ref s i)])
          (cond
            [(char-numeric? c)
             (loop (+ i 1) stack (+ (* num 10) (- (char->integer c) 48)) sign)]
            [(or (char=? c #\+) (char=? c #\-) (char=? c #\*) (char=? c #\/))
             (let ([new-stack (if (or (char=? sign #\*) (char=? sign #\/))
                                 (cons (apply-op sign (car stack) num) (cdr stack))
                                 (cons (apply-op sign 0 num) stack))])
               (loop (+ i 1) new-stack 0 c))]
            [else
             (loop (+ i 1) stack num sign)])))))