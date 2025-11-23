(define/contract (remove-duplicates s k)
  (-> string? exact-integer? string?)
  (let loop ([chars (string->list s)]
             [stack '()])
    (if (null? chars)
        (list->string (reverse (apply append (map (lambda (x) (make-list (car x) (cdr x))) stack))))
        (let* ([current-char (car chars)]
               [rest-chars (cdr chars)]
               [top (if (null? stack) #f (car stack))])
          (if (and top (char=? (cdr top) current-char))
              (let ([new-count (+ (car top) 1)])
                (if (= new-count k)
                    (loop rest-chars (cdr stack))
                    (loop rest-chars (cons (cons new-count current-char) (cdr stack)))))
              (loop rest-chars (cons (cons 1 current-char) stack)))))))