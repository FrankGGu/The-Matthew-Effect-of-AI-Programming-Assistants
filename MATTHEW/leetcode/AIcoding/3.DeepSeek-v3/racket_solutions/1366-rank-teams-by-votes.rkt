(define (rank-teams votes)
  (let* ([n (string-length (car votes))]
         [teams (string->list (car votes))]
    (list->string
     (sort teams
           (lambda (a b)
             (let loop ([i 0])
               (cond
                 [(= i n) (char<? a b)]
                 [else
                  (let ([count-a (count (lambda (vote) (char=? a (string-ref vote i))) votes)]
                        [count-b (count (lambda (vote) (char=? b (string-ref vote i))) votes)])
                    (cond
                      [(> count-a count-b) #t]
                      [(< count-a count-b) #f]
                      [else (loop (add1 i))]))))))))