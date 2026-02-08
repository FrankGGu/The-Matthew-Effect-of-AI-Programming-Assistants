(define (are-numbers-ascending s)
  (let loop ([words (string-split s)] [prev -inf.0])
    (cond
      [(empty? words) #t]
      [else
       (let ([word (car words)])
         (if (string->number word)
             (let ([num (string->number word)])
               (if (> num prev)
                   (loop (cdr words) num)
                   #f))
             (loop (cdr words) prev)))])))