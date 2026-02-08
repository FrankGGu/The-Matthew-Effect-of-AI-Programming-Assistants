(define/contract (last-visited-integers words)
  (-> (listof string?) (listof integer?))
  (let loop ([words words]
             [seen '()]
             [result '()]
             [k 0])
    (if (null? words)
        (reverse result)
        (let ([word (car words)])
          (if (string=? word "prev")
              (let ([n (length seen)])
                (if (<= k n)
                    (loop (cdr words)
                          seen
                          (cons (list-ref seen (- k 1)) result)
                          (+ k 1))
                    (loop (cdr words)
                          seen
                          (cons -1 result)
                          (+ k 1))))
              (loop (cdr words)
                    (cons (string->number word) seen)
                    result
                    0))))))