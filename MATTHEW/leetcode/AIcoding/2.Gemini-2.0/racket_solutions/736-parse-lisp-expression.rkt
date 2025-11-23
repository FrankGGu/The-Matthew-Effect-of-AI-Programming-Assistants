(define (parse-lisp-expression expression)
  (define (tokenize expr)
    (string->list expr))

  (define (parse tokens env)
    (cond
      [(empty? tokens) (error "Unexpected end of expression")]
      [(char=? (car tokens) #\()
       (let* [(rest (cdr tokens))]
         (cond
           [(empty? rest) (error "Empty expression")]
           [(char=? (car rest) #\l)
            (let* [(op (string->symbol (list->string (take rest 4))))
                   (rest2 (drop rest 4))
                   (operand1 (parse rest2 env))
                   (rest3 (drop (length (list->string (number->string operand1))) rest2))
                   (operand2 (parse rest3 env))
                   (rest4 (drop (length (list->string (number->string operand2))) rest3))
                   (rest5 (cdr rest4))]
              (if (char=? (car rest4) #\))
                  (list (- operand1 operand2) rest5)
                  (error "Missing closing parenthesis")))
            ]
           [(char=? (car rest) #\m)
            (let* [(op (string->symbol (list->string (take rest 4))))
                   (rest2 (drop rest 4))
                   (operand1 (parse rest2 env))
                   (rest3 (drop (length (list->string (number->string operand1))) rest2))
                   (operand2 (parse rest3 env))
                   (rest4 (drop (length (list->string (number->string operand2))) rest3))
                   (rest5 (cdr rest4))]
              (if (char=? (car rest4) #\))
                  (list (+ operand1 operand2) rest5)
                  (error "Missing closing parenthesis")))
            ]
           [(char=? (car rest) #\l)
            (let* [(op (string->symbol (list->string (take rest 4))))
                   (rest2 (drop rest 4))
                   (operand1 (parse rest2 env))
                   (rest3 (drop (length (list->string (number->string operand1))) rest2))
                   (operand2 (parse rest3 env))
                   (rest4 (drop (length (list->string (number->string operand2))) rest3))
                   (rest5 (cdr rest4))]
              (if (char=? (car rest4) #\))
                  (list (- operand1 operand2) rest5)
                  (error "Missing closing parenthesis")))
            ]
           [(char=? (car rest) #\l)
            (let* [(op (string->symbol (list->string (take rest 4))))
                   (rest2 (drop rest 4))
                   (operand1 (parse rest2 env))
                   (rest3 (drop (length (list->string (number->string operand1))) rest2))
                   (operand2 (parse rest3 env))
                   (rest4 (drop (length (list->string (number->string operand2))) rest3))
                   (rest5 (cdr rest4))]
              (if (char=? (car rest4) #\))
                  (list (- operand1 operand2) rest5)
                  (error "Missing closing parenthesis")))
            ]
           [(char=? (car rest) #\l)
            (let* [(op (string->symbol (list->string (take rest 4))))
                   (rest2 (drop rest 4))
                   (operand1 (parse rest2 env))
                   (rest3 (drop (length (list->string (number->string operand1))) rest2))
                   (operand2 (parse rest3 env))
                   (rest4 (drop (length (list->string (number->string operand2))) rest3))
                   (rest5 (cdr rest4))]
              (if (char=? (car rest4) #\))
                  (list (- operand1 operand2) rest5)
                  (error "Missing closing parenthesis")))
            ]
           [(char=? (car rest) #\l)
            (let* [(op (string->symbol (list->string (take rest 4))))
                   (rest2 (drop rest 4))
                   (operand1 (parse rest2 env))
                   (rest3 (drop (length (list->string (number->string operand1))) rest2))
                   (operand2 (parse rest3 env))
                   (rest4 (drop (length (list->string (number->string operand2))) rest3))
                   (rest5 (cdr rest4))]
              (if (char=? (car rest4) #\))
                  (list (- operand1 operand2) rest5)
                  (error "Missing closing parenthesis")))
            ]
           [(char=? (car rest) #\l)
            (let* [(op (string->symbol (list->string (take rest 4))))
                   (rest2 (drop rest 4))
                   (operand1 (parse rest2 env))
                   (rest3 (drop (length (list->string (number->string operand1))) rest2))
                   (operand2 (parse rest3 env))
                   (rest4 (drop (length (list->string (number->string operand2))) rest3))
                   (rest5 (cdr rest4))]
              (if (char=? (car rest4) #\))
                  (list (- operand1 operand2) rest5)
                  (error "Missing closing parenthesis")))
            ]
           [(char=? (car rest) #\l)
            (let* [(op (string->symbol (list->string (take rest 4))))
                   (rest2 (drop rest 4))
                   (operand1 (parse rest2 env))
                   (rest3 (drop (length (list->string (number->string operand1))) rest2))
                   (operand2 (parse rest3 env))
                   (rest4 (drop (length (list->string (number->string operand2))) rest3))
                   (rest5 (cdr rest4))]
              (if (char=? (car rest4) #\))
                  (list (- operand1 operand2) rest5)
                  (error "Missing closing parenthesis")))
            ]
           [(char=? (car rest) #\d)
            (let* [(op (string->symbol (list->string (take rest 3))))
                   (rest2 (drop rest 3))
                   (var (string->symbol (list->string (take rest2 1))))
                   (rest3 (drop 1 rest2))
                   (val (parse rest3 env))
                   (rest4 (drop (length (list->string (number->string (car val)))) rest3))
                   (rest5 (cdr rest4))
                   (new-env (cons (cons var (car val)) env))
                   (result (parse rest5 new-env))
                   (rest6 (cdr result))]
              (if (char=? (car rest4) #\))
                  (list (car result) rest6)
                  (error "Missing closing parenthesis")))
            ]
           [else
            (let* [(op (string->symbol (list->string (take rest 3))))
                   (rest2 (drop rest 3))
                   (var (string->symbol (list->string (take rest2 1))))
                   (rest3 (drop 1 rest2))
                   (val (parse rest3 env))
                   (rest4 (drop (length (list->string (number->string (car val)))) rest3))
                   (rest5 (cdr rest4))
                   (new-env (cons (cons var (car val)) env))
                   (result (parse rest5 new-env))
                   (rest6 (cdr result))]
              (if (char=? (car rest4) #\))
                  (list (car result) rest6)
                  (error "Missing closing parenthesis")))
            ]
           ))]
      [(char=? (car tokens) #\)) (error "Unexpected closing parenthesis")]
      [(char=? (car tokens) #\ ) (parse (cdr tokens) env)]
      [(char=? (car tokens) #\t) (parse (cdr tokens) env)]
      [(char=? (car tokens) #\n) (parse (cdr tokens) env)]
      [(char=? (car tokens) #\r) (parse (cdr tokens) env)]
      [else
       (let* [(num-str (list->string (take-while char-numeric? tokens)))
              (num (string->number num-str))
              (rest (drop (string-length num-str) tokens))]
         (list num rest))]
      ))

  (define (char-numeric? c)
    (or (char>=? c #\0) (char<=? c #\9) (char=? c #\-)))