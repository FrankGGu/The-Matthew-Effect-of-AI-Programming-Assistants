(define (calculate s)
  (define (tokenize str)
    (let loop ([str (string-trim str)] [tokens '()])
      (cond
        [(string=? str "") (reverse tokens)]
        [(char=? (string-ref str 0) #\space) (loop (string-trim str) tokens)]
        [(char=? (string-ref str 0) #\+) (loop (substring str 1) (cons '+ tokens))]
        [(char=? (string-ref str 0) #\-) (loop (substring str 1) (cons '- tokens))]
        [(char=? (string-ref str 0) #\() (loop (substring str 1) (cons 'L tokens))]
        [(char=? (string-ref str 0) #\)) (loop (substring str 1) (cons 'R tokens))]
        [else
         (let* ([i (for/first ([i (in-range (string-length str))]
                             #:when (not (char-numeric? (string-ref str i)))
                             i)
                   (string-length str))]
                [num-str (substring str 0 i)]
                [rest-str (substring str i)])
           (loop rest-str (cons (string->number num-str) tokens)))])))

  (define (eval tokens)
    (let loop ([tokens tokens] [result 0] [op '+])
      (cond
        [(null? tokens) result]
        [(number? (car tokens))
         (loop (cdr tokens)
               (case op
                 ['+ (+ result (car tokens))]
                 ['- (- result (car tokens))])
               op)]
        [(eq? (car tokens) '+) (loop (cdr tokens) result '+)]
        [(eq? (car tokens) '-) (loop (cdr tokens) result '-)]
        [(eq? (car tokens) 'L)
         (let-values ([(new-result new-tokens) (eval (cdr tokens))])
           (loop new-tokens
                 (case op
                   ['+ (+ result new-result)]
                   ['- (- result new-result)])
                 op))]
        [(eq? (car tokens) 'R) (values result (cdr tokens))]
        [else (error "Invalid token: " (car tokens))])))

  (define tokens (tokenize s))
  (eval tokens))