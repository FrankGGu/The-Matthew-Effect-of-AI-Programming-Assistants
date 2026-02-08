(define (parseBoolExpr expression)
  (define (eval-expr expr)
    (cond
      [(equal? expr #\t) #t]
      [(equal? expr #\f) #f]
      [(equal? (string-ref expr 0) #\!) (not (eval-expr (substring expr 2 (sub1 (string-length expr))))) ]
      [else
       (define op (string-ref expr 0))
       (define lst (parse-args (substring expr 2 (sub1 (string-length expr)))))
       (case op
         [(#\a) (and lst)]
         [(#\o) (or lst)]
         [(#\x) (foldl (lambda (x y) (xor x y)) #f lst)]))]))

  (define (parse-args args)
    (define parsed '())
    (define i 0)
    (define n (string-length args))
    (let loop ()
      (when (< i n)
        (cond
          [(equal? (string-ref args i) #\,) (set! i (+ i 1)) (loop)]
          [else (set! parsed (cons (read-expr args) parsed)) (loop)])))
    (reverse parsed))

  (define (read-expr args)
    (if (equal? (string-ref args 0) #\() 
        (let ([end (find-matching-paren args 0)])
          (parseBoolExpr (substring args 1 end)))
        (if (equal? (string-ref args 0) #\t)
            #t
            #f)))

  (define (find-matching-paren args start)
    (define count 1)
    (define i (+ start 1))
    (let loop ()
      (if (< i (string-length args))
          (cond
            [(equal? (string-ref args i) #\() (set! count (+ count 1)) (set! i (+ i 1)) (loop)]
            [(equal? (string-ref args i) #\)) (set! count (- count 1)) (if (= count 0) i (set! i (+ i 1))) (loop)]
            [else (set! i (+ i 1)) (loop)])
          (error "No matching parenthesis"))))

  (eval-expr expression))