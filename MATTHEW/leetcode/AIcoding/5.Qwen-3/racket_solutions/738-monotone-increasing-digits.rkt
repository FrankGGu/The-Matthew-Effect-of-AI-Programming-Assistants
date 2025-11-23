(define (monotone-increasing-digits n)
  (define (to-list n)
    (if (= n 0)
        '()
        (cons (remainder n 10) (to-list (quotient n 10)))))
  (define (from-list ls)
    (if (null? ls)
        0
        (+ (* (car ls) (expt 10 (length (cdr ls)))) (from-list (cdr ls)))))
  (define (helper ls)
    (cond [(null? (cdr ls)) ls]
          [(<= (car ls) (cadr ls)) (cons (car ls) (helper (cdr ls)))]
          [else (cons (- (car ls) 1) (make-list (length (cdr ls)) 9))]))
  (from-list (helper (to-list n))))