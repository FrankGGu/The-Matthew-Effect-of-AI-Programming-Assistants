(define (solveEquation equation)
  (define (parse-term term)
    (cond
      ((string=? term "") (values 0 0))
      ((string-contains? term "x")
       (define coeff (string->number (if (string=? (substring term 0 1) "x") "1" 
                                          (if (string=? (substring term 0 2) "-x") "-1" 
                                              (substring term 0 (string-index term "x")))))))
       (values coeff 1))
      (else (values (string->number term) 0))))

  (define (parse-equation eq)
    (define parts (string-split eq "="))
    (define lhs (string-split (car parts) "+"))
    (define rhs (string-split (cadr parts) "+"))
    (define (process-terms terms)
      (foldl (lambda (term acc)
                (define-values (coeff x) (parse-term term))
                (values (+ (car acc) coeff) (+ (cdr acc) x)))
              (values 0 0)
              terms))
    (define-values (left-coeff left-x) (process-terms lhs))
    (define-values (right-coeff right-x) (process-terms rhs))
    (values (- left-coeff right-coeff) (- right-x left-x)))

  (define-values (const x) (parse-equation equation))
  (if (zero? x)
      (if (zero? const)
          "Infinite solutions"
          "No solution")
      (format "x=~a" (/ const x))))

(define (main)
  (display (solveEquation "x+5-3+x=6+x-2")))

(main)