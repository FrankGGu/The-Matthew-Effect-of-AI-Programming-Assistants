(define (find-replace-string s indices sources targets)
  (let loop ([i 0]
             [result '()]
             [indices (sort (map (lambda (x) (list (car x) (cadr x) (caddr x))) 
                                (map list indices sources targets)) 
                         < #:key car)])
    (cond
      [(>= i (string-length s)) (list->string (reverse result))]
      [(null? indices) (list->string (reverse (append (reverse (string->list (substring s i))) result)))]
      [(= i (caar indices))
       (let* ([index (caar indices)]
              [source (cadar indices)]
              [target (caddar indices)]
              [source-len (string-length source)])
         (if (and (<= (+ index source-len) (string-length s))
                  (string=? source (substring s index (+ index source-len))))
             (loop (+ index source-len) 
                   (append (reverse (string->list target)) result)
                   (cdr indices))
             (loop (add1 i) (cons (string-ref s i) result) (cdr indices))))]
      [else (loop (add1 i) (cons (string-ref s i) result) indices)])))