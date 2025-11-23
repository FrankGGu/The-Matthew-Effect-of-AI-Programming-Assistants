(define (are-almost-equal s1 s2)
  (define (diff-indices s1 s2)
    (let loop ([s1-lst (string->list s1)]
               [s2-lst (string->list s2)]
               [indices '()]
               [index 0])
      (cond
        [(empty? s1-lst) indices]
        [else (if (equal? (car s1-lst) (car s2-lst))
                  (loop (cdr s1-lst) (cdr s2-lst) indices (+ index 1))
                  (loop (cdr s1-lst) (cdr s2-lst) (append indices (list index)) (+ index 1)))])))

  (let ([indices (diff-indices s1 s2)])
    (cond
      [(empty? indices) #t]
      [(= (length indices) 2)
       (let ([i (car indices)]
             [j (cadr indices)])
         (and (equal? (string-ref s1 i) (string-ref s2 j))
              (equal? (string-ref s1 j) (string-ref s2 i))))]
      [else #f])))