(define (my-atoi s)
  (define (is-digit? c)
    (and (char? c) (>= (char->integer c) (char->integer #\0)) (<= (char->integer c) (char->integer #\9))))

  (define (trim s)
    (let loop ((s s))
      (if (and (not (null? s)) (char=? (car s) #\space))
          (loop (cdr s))
          s)))

  (define s (trim (string->list s)))
  (if (null? s) 0)

  (define sign (if (char=? (car s) #\-) -1 1))
  (define start (if (or (char=? (car s) #\-) (char=? (car s) #\+)) 1 0))

  (define (parse s)
    (let loop ((s s) (result 0))
      (if (and (not (null? s)) (is-digit? (car s)))
          (let ((digit (- (char->integer (car s)) (char->integer #\0))))
            (if (or (> (* result 10) (quotient most-positive-fixnum 10))
                    (and (= (* result 10) (quotient most-positive-fixnum 10)) (> digit (modulo most-positive-fixnum 10))))
                (if (= sign -1) most-negative-fixnum most-positive-fixnum)
                (loop (cdr s) (+ (* result 10) digit))))
          result)))

  (define result (parse (cdr s)))
  (* sign result))

(my-atoi "   -42")