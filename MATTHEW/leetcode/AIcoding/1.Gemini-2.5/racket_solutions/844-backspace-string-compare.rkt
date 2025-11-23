(define (backspace-compare s t)
  (define (process-string str)
    (define (iter chars acc)
      (cond
        [(empty? chars)
         (list->string (reverse acc))]
        [else
         (let ([char (car chars)])
           (if (char=? char #\#)
               (iter (cdr chars) (if (empty? acc) acc (cdr acc)))
               (iter (cdr chars) (cons char acc))))]))
    (iter (string->list str) '()))
  (string=? (process-string s) (process-string t)))