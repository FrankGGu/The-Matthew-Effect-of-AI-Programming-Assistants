(define (count-asterisks s)
  (for/fold ([count 0]
             [in-pair? #f])
            ([c (in-string s)])
    (cond
      [(char=? c #\|)
       (values count (not in-pair?))]
      [(and (not in-pair?) (char=? c #\*))
       (values (add1 count) in-pair?)]
      [else
       (values count in-pair?)])))