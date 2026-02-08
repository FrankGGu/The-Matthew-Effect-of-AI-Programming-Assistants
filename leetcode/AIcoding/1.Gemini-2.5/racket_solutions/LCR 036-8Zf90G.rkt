(define (eval-rpn tokens)
  (define (eval-rpn-helper tokens stack)
    (cond
      ((empty? tokens)
       (car stack))
      (else
       (let* ((token (car tokens))
              (num (string->number token)))
         (if num ; It's a number
             (eval-rpn-helper (cdr tokens) (cons num stack))
             ; It's an operator
             (let* ((op2 (car stack))
                    (stack-after-op2 (cdr stack))
                    (op1 (car stack-after-op2))
                    (stack-after-op1 (cdr stack-after-op2))
                    (result (cond
                              ((string=? token "+") (+ op1 op2))
                              ((string=? token "-") (- op1 op2))
                              ((string=? token "*") (* op1 op2))
                              ((string=? token "/") (quotient op1 op2))
                              (else (error "Unknown operator")))))
               (eval-rpn-helper (cdr tokens) (cons result stack-after-op1))))))))
  (eval-rpn-helper tokens '()))