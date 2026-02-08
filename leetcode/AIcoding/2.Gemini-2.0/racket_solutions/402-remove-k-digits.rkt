(define (remove-kdigits num k)
  (let loop ((num (string->list num))
             (k k)
             (stack '()))
    (cond
      [(empty? num)
       (cond
         [(zero? k) (list->string (if (empty? stack) '(#\0) stack))]
         [else (list->string (if (empty? (drop-right stack k)) '(#\0) (drop-right stack k)))])]
      [else
       (let ((digit (car num))
             (rest (cdr num)))
         (cond
           [(zero? k) (list->string (append stack num))]
           [else
            (cond
              [(empty? stack) (loop rest k (list digit))]
              [else
               (let ((top (car stack)))
                 (cond
                   [(<= digit top) (loop rest k (cons digit stack))]
                   [else (loop rest (sub1 k) (cdr stack))]))])])])]))

  (let ((res (remove-kdigits num k)))
    (cond
      [(and (> (string-length res) 1) (char=? (string-ref res 0) #\0))
       (let loop ((s (string->list res)))
         (cond
           [(empty? s) "0"]
           [(char=? (car s) #\0) (loop (cdr s))]
           [else (list->string s)]))]
      [else res])))