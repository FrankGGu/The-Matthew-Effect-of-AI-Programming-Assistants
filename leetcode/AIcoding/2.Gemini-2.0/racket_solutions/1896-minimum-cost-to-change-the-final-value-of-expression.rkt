(require racket/string
         racket/list)

(define (min-cost-to-change (expression string?))
  (define (eval-expression (s string?))
    (define (parse-expr (expr string?))
      (define (is-op (c char?))
        (or (char=? c '&') (char=? c '|')))

      (define (tokenize (s string?))
        (let loop ((i 0) (tokens '()) (curr ""))
          (cond
            ((= i (string-length s))
             (if (string=? curr "")
                 (reverse tokens)
                 (reverse (cons curr tokens))))
            (else
             (let ((c (string-ref s i)))
               (cond
                 ((char=? c '(')
                  (if (string=? curr "")
                      (loop (+ i 1) (cons "(" tokens) "")
                      (loop (+ i 1) (cons "(" (cons curr tokens)) "")))
                 ((char=? c ')')
                  (if (string=? curr "")
                      (loop (+ i 1) (cons ")" tokens) "")
                      (loop (+ i 1) (cons ")" (cons curr tokens)) "")))
                 ((is-op c)
                  (if (string=? curr "")
                      (loop (+ i 1) (cons (string c) tokens) "")
                      (loop (+ i 1) (cons (string c) (cons curr tokens)) "")))
                 ((char=? c ' '))
                  (if (string=? curr "")
                      (loop (+ i 1) tokens "")
                      (loop (+ i 1) (cons curr tokens) "")))
                 (else
                  (loop (+ i 1) tokens (string-append curr (string c))))))))))

      (define (build-ast (tokens (listof string?)))
        (define (parse-helper (tokens (listof string?)))
          (cond
            ((empty? tokens) (values #f '()))
            (else
             (let ((token (car tokens)))
               (cond
                 ((string=? token "(")
                  (let-values (((left-node rest-tokens-after-left) (parse-helper (cdr tokens))))
                    (if (empty? rest-tokens-after-left)
                        (error "Missing operator after left parenthesis")
                        (let ((op (car rest-tokens-after-left)))
                          (if (not (or (string=? op "&") (string=? op "|")))
                              (error "Expected operator, found: " op)
                              (let-values (((right-node rest-tokens-after-right) (parse-helper (cdr rest-tokens-after-left))))
                                (if (empty? rest-tokens-after-right)
                                    (error "Missing closing parenthesis")
                                    (if (not (string=? (car rest-tokens-after-right) ")"))
                                        (error "Expected closing parenthesis, found: " (car rest-tokens-after-right))
                                        (values (list op left-node right-node) (cdr rest-tokens-after-right))))))))))
                 ((string=? token ")") (error "Unexpected closing parenthesis"))
                 (else (values token (cdr tokens))))))))
        (car (parse-helper tokens)))

      (define (evaluate (node))
        (cond
          ((string? node) (string=? node "1"))
          (else
           (let ((op (car node))
                 (left (cadr node))
                 (right (caddr node)))
             (cond
               ((string=? op "&") (and (evaluate left) (evaluate right)))
               ((string=? op "|") (or (evaluate left) (evaluate right)))
               (else (error "Invalid operator: " op)))))))

      (evaluate (build-ast (tokenize expr))))
    (if (eval-expression s) 1 0))

  (define (min-cost (expression string?))
    (define n (string-length expression))
    (define dp (make-vector (+ n 1) (make-vector 2 1000000)))

    (vector-set! (vector-ref dp 0) 0 0)
    (vector-set! (vector-ref dp 0) 1 0)

    (for ((i (in-range 1 (+ n 1))))
      (let ((c (string-ref expression (- i 1))))
        (cond
          ((char=? c '0')
           (vector-set! (vector-ref dp i) 0 (vector-ref (vector-ref dp (- i 1)) 0))
           (vector-set! (vector-ref dp i) 1 (+ 1 (vector-ref (vector-ref dp (- i 1)) 0))))
          ((char=? c '1')
           (vector-set! (vector-ref dp i) 0 (+ 1 (vector-ref (vector-ref dp (- i 1)) 1)))
           (vector-set! (vector-ref dp i) 1 (vector-ref (vector-ref dp (- i 1)) 1)))
          ((char=? c '&')
           (vector-set! (vector-ref dp i) 0 (min (+ 1 (vector-ref (vector-ref dp (- i 1)) 0)) (+ 1 (vector-ref (vector-ref dp (- i 1)) 1))))
           (vector-set! (vector-ref dp i) 1 (min (vector-ref (vector-ref dp (- i 1)) 1) (+ 1 (vector-ref (vector-ref dp (- i 1)) 0))))
          ((char=? c '|')
           (vector-set! (vector-ref dp i) 0 (min (vector-ref (vector-ref dp (- i 1)) 0) (+ 1 (vector-ref (vector-ref dp (- i 1)) 1))))
           (vector-set! (vector-ref dp i) 1 (min (+ 1 (vector-ref (vector-ref dp (- i 1)) 0)) (+ 1 (vector-ref (vector-ref dp (- i 1)) 1))))
          (else
           (vector-set! (vector-ref dp i) 0 (vector-ref (vector-ref dp (- i 1)) 0))
           (vector-set! (vector-ref dp i) 1 (vector-ref (vector-ref dp (- i 1)) 1))))) )

    (vector-ref (vector-ref dp n) (eval-expression expression)))
  (min-cost expression))