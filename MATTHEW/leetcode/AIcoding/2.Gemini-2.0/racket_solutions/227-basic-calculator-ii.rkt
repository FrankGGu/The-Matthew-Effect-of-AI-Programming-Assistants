(define (calculate s)
  (define (string->list str)
    (string->list str))

  (define (tokenize lst)
    (define (is-digit? char)
      (char>=? char #\0)
      (char<=? char #\9))

    (define (is-operator? char)
      (or (char=? char #\+)
          (char=? char #\-)
          (char=? char #\*)
          (char=? char #\/)))

    (define (tokenize-helper lst acc current-num)
      (cond
        [(empty? lst)
         (if (empty? current-num)
             acc
             (append acc (list (string->number (list->string current-num)))))]
        [(char=? (car lst) #\space)
         (if (empty? current-num)
             (tokenize-helper (cdr lst) acc current-num)
             (tokenize-helper (cdr lst) (append acc (list (string->number (list->string current-num))))) '())]
        [(is-digit? (car lst))
         (tokenize-helper (cdr lst) acc (append current-num (list (car lst))))]
        [(is-operator? (car lst))
         (if (empty? current-num)
             (tokenize-helper (cdr lst) (append acc (list (car lst))) '())
             (tokenize-helper (cdr lst) (append acc (list (string->number (list->string current-num))) (list (car lst))) '()))]
        [else (error "Invalid character")]))

    (tokenize-helper lst '() '()))

  (define (eval tokens)
    (define (eval-helper tokens acc op)
      (cond
        [(empty? tokens) acc]
        [(char=? (car tokens) #\+)
         (eval-helper (cdr tokens) acc '+)]
        [(char=? (car tokens) #\-)
         (eval-helper (cdr tokens) acc '-)]
        [(char=? (car tokens) #\*)
         (eval-helper (cdr tokens) acc '*')]
        [(char=? (car tokens) #\/)
         (eval-helper (cdr tokens) acc '/)]
        [else
         (let ((num (car tokens)))
           (cond
             [(eq? op '+) (eval-helper (cdr tokens) (+ acc num) #\+)]
             [(eq? op '-) (eval-helper (cdr tokens) (- acc num) #\+)]
             [(eq? op '*) (eval-helper (cdr tokens) (* acc num) #\+)]
             [(eq? op '/) (eval-helper (cdr tokens) (truncate (/ acc num)) #\+)]
             [else (eval-helper (cdr tokens) num #\+)]))]))

    (define (precedence op)
      (cond
        [(or (char=? op #\*) (char=? op #\/)) 2]
        [(or (char=? op #\+) (char=? op #\-)) 1]
        [else 0]))

    (define (transform-to-postfix tokens)
      (define (transform-helper tokens stack output)
        (cond
          [(empty? tokens) (append output (reverse stack))]
          [(number? (car tokens)) (transform-helper (cdr tokens) stack (append output (list (car tokens))))]
          [(char=? (car tokens) #\+) (transform-helper (cdr tokens) (push-op stack (car tokens)) output)]
          [(char=? (car tokens) #\-) (transform-helper (cdr tokens) (push-op stack (car tokens)) output)]
          [(char=? (car tokens) #\*) (transform-helper (cdr tokens) (push-op stack (car tokens)) output)]
          [(char=? (car tokens) #\/) (transform-helper (cdr tokens) (push-op stack (car tokens)) output)]
          [else (error "Invalid token")]))

      (define (push-op stack op)
        (cond
          [(empty? stack) (list op)]
          [(>= (precedence (car stack)) (precedence op))
           (append (push-op (cdr stack) op) (list (car stack)))]
          [else (cons op stack)]))

      (transform-helper tokens '() '()))

    (define (evaluate-postfix postfix)
      (define (evaluate-helper postfix stack)
        (cond
          [(empty? postfix) (car stack)]
          [(number? (car postfix)) (evaluate-helper (cdr postfix) (cons (car postfix) stack))]
          [(char=? (car postfix) #\+) (evaluate-helper (cdr postfix) (cons (+ (cadr stack) (car stack)) (cddr stack)))]
          [(char=? (car postfix) #\-) (evaluate-helper (cdr postfix) (cons (- (cadr stack) (car stack)) (cddr stack)))]
          [(char=? (car postfix) #\*) (evaluate-helper (cdr postfix) (cons (* (cadr stack) (car stack)) (cddr stack)))]
          [(char=? (car postfix) #\/) (evaluate-helper (cdr postfix) (cons (truncate (/ (cadr stack) (car stack))) (cddr stack)))]
          [else (error "Invalid operator")]))

      (evaluate-helper postfix '()))

    (evaluate-postfix (transform-to-postfix tokens)))

  (eval (tokenize (string->list s))))