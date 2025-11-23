(define (remove-anagrams words)
  (let loop ([prev ""] [rest words] [result '()])
    (cond
      [(empty? rest) (reverse result)]
      [else
       (let* ([current (first rest)]
              [sorted-current (list->string (sort (string->list current) char<?))])
         (if (string=? sorted-current prev)
             (loop prev (rest rest) result)
             (loop sorted-current (rest rest) (cons current result))))])))