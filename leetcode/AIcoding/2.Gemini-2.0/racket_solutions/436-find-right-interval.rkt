(define (find-right-interval intervals)
  (let* ([n (length intervals)]
         [starts (map car intervals)]
         [indexed-starts (map list starts (range n))]
         [sorted-indexed-starts (sort indexed-starts < #:key car)])
    (map (lambda (interval)
           (let ([end (cadr interval)])
             (let loop ([indexed-starts sorted-indexed-starts])
               (cond
                 [(null? indexed-starts) -1]
                 [(>= (caar indexed-starts) end) (cadr (car indexed-starts))]
                 [else (loop (cdr indexed-starts))]
                 ))))
         intervals)))