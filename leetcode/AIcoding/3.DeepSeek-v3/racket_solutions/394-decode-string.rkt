(define/contract (decode-string s)
  (-> string? string?)
  (let loop ([i 0] [stack '()])
    (if (>= i (string-length s))
        (if (null? stack)
            ""
            (car stack))
        (let ([c (string-ref s i)])
          (cond
            [(char-numeric? c)
             (let ([num-start i])
               (let num-loop ([j (add1 i)])
                 (if (char-numeric? (string-ref s j))
                     (num-loop (add1 j))
                     (let ([num (string->number (substring s num-start j))])
                       (loop j (cons num stack))))))]
            [(char=? c #\[)
             (loop (add1 i) (cons "" stack))]
            [(char=? c #\])
             (let* ([str (car stack)]
                    [stack (cdr stack)]
                    [num (car stack)]
                    [stack (cdr stack)]
                    [prev (if (null? stack) "" (car stack))]
                    [stack (if (null? stack) '() (cdr stack))])
               (loop (add1 i) (cons (string-append prev (make-string num (lambda (_) str))) stack)))]
            [else
             (let ([prev (if (null? stack) "" (car stack))])
               (loop (add1 i) (cons (string-append prev (string c)) (if (null? stack) '() (cdr stack))))])))))