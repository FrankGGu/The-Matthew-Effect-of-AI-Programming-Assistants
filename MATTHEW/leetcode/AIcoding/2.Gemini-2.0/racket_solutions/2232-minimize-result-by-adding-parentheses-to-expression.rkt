(define (minimize-result expression)
  (define (eval-expr s)
    (eval (read (open-input-string s))))

  (define (find-min-result expression)
    (define len (string-length expression))
    (define (helper left right)
      (cond
        [(>= left right) +inf.0]
        [else
         (let* ([expr (string-append (substring expression 0 left)
                                     "("
                                     (substring expression left right)
                                     ")"
                                     (substring expression right len))]
                [result (eval-expr expr)])
           (min result (helper left (+ 1 right)) (helper (+ 1 left) right)))]))
    (helper 1 (- len 1)))

  (define (find-min-expr expression)
    (define len (string-length expression))
    (define min-result (find-min-result expression))
    (define (helper left right)
      (cond
        [(>= left right) ""]
        [else
         (let* ([expr (string-append (substring expression 0 left)
                                     "("
                                     (substring expression left right)
                                     ")"
                                     (substring expression right len))]
                [result (eval-expr expr)])
           (if (= result min-result)
               expr
               (let ([left-expr (helper left (+ 1 right))]
                     [right-expr (helper (+ 1 left) right)])
                 (cond
                   [(and (string=? left-expr "") (string=? right-expr "")) ""]
                   [(string=? left-expr "") right-expr]
                   [(string=? right-expr "") left-expr]
                   [else
                    (if (< (string-length left-expr) (string-length right-expr))
                        left-expr
                        right-expr)]))))]))
    (helper 1 (- len 1)))

  (find-min-expr expression))