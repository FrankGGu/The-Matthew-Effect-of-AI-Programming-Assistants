(define/contract (maximum-number-of-string-pairs words)
  (-> (listof string?) exact-integer?)
  (let loop ([words words] [count 0])
    (if (null? words)
        count
        (let* ([current (car words)]
               [reversed (list->string (reverse (string->list current)))])
          (loop (cdr words)
                (if (member reversed (cdr words))
                    (add1 count)
                    count))))))