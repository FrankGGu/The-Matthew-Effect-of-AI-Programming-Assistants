(define/contract (max-free-time intervals)
  (-> (listof (listof exact-integer?)) exact-integer?)
  (let* ([sorted-intervals (sort intervals (lambda (a b) (< (car a) (car b))))]
         [merged (let loop ([intervals sorted-intervals] [result '()])
                  (if (null? intervals)
                      (reverse result)
                      (let ([current (car intervals)]
                            [rest (cdr intervals)])
                        (if (null? result)
                            (loop rest (list current))
                            (let ([last-merged (car result)])
                              (if (<= (car current) (cadr last-merged))
                                  (loop rest (cons (list (car last-merged) (max (cadr last-merged) (cadr current))) (cdr result)))
                                  (loop rest (cons current result))))))))]
         [gaps (let loop ([intervals merged] [max-gap 0])
                 (if (or (null? intervals) (null? (cdr intervals)))
                     max-gap
                     (let ([gap (- (caadr intervals) (cadar intervals))])
                       (loop (cdr intervals) (max max-gap gap)))))])
    gaps))