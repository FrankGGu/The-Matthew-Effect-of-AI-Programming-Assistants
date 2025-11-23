(define (eval-rpn tokens)
  (define (eval-rpn-helper tokens stack)
    (cond
      ((empty? tokens) (car stack))
      (else
       (let* ((token (car tokens))
              (rest-tokens (cdr tokens)))
         (case token
           ("+" (let ((val2 (car stack)) (stack-rest (cdr stack)))
                   (let ((val1 (car stack-rest)) (stack-rest-rest (cdr stack-rest)))
                     (eval-rpn-helper rest-tokens (cons (+ val1 val2) stack-rest-rest)))))
           ("-" (let ((val2 (car stack)) (stack-rest (cdr stack)))
                   (let ((val1 (car stack-rest)) (stack-rest-rest (cdr stack-rest)))
                     (eval-rpn-helper rest-tokens (cons (- val1 val2) stack-rest-rest)))))
           ("*" (let ((val2 (car stack)) (stack-rest (cdr stack)))
                   (let ((val1 (car stack-rest)) (stack-rest-rest (cdr stack-rest)))
                     (eval-rpn-helper rest-tokens (cons (* val1 val2) stack-rest-rest)))))
           ("/" (let ((val2 (car stack)) (stack-rest (cdr stack)))
                   (let ((val1 (car stack-rest)) (stack-rest-rest (cdr stack-rest)))
                     (eval-rpn-helper rest-tokens (cons (quotient val1 val2) stack-rest-rest)))))
           (else
            (eval-rpn-helper rest-tokens (cons (string->number token) stack))))))))
  (eval-rpn-helper tokens '()))