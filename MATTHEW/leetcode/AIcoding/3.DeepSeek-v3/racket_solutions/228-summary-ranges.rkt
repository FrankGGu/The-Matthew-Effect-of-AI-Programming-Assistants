(define/contract (summary-ranges nums)
  (-> (listof exact-integer?) (listof string?))
  (cond
    [(null? nums) '()]
    [else
     (let loop ([start (car nums)] [end (car nums)] [rest (cdr nums)] [result '()])
       (cond
         [(null? rest)
          (reverse (cons (if (= start end)
                            (number->string start)
                            (string-append (number->string start) "->" (number->string end)))
                         result))]
         [(= (car rest) (+ end 1))
          (loop start (car rest) (cdr rest) result)]
         [else
          (loop (car rest) (car rest) (cdr rest)
                (cons (if (= start end)
                          (number->string start)
                          (string-append (number->string start) "->" (number->string end)))
                      result))]))]))