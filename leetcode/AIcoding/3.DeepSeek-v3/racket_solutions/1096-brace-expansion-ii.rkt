#lang racket

(define (brace-expansion-ii expr)
  (define (parse s)
    (let loop ([s s] [stack '()] [current '()] [result '()])
      (cond
        [(string=? s "") 
         (let ([new-current (if (null? current) result (cons current result))])
           (if (null? stack) 
               (combine (reverse new-current))
               (let-values ([(prev-stack prev-current prev-result) (car stack)])
                 (loop "" (cdr stack) (cons (combine (reverse new-current)) prev-current) prev-result))))]
        [(char=? (string-ref s 0) #\{)
         (loop (substring s 1) 
               (cons (list stack current result) stack) 
               '() 
               '())]
        [(char=? (string-ref s 0) #\})
         (let ([new-current (if (null? current) result (cons current result))])
           (if (null? stack)
               (combine (reverse new-current))
               (let-values ([(prev-stack prev-current prev-result) (car stack)])
                 (loop (substring s 1) 
                       (cdr stack) 
                       (cons (combine (reverse new-current)) prev-current) 
                       prev-result))))]
        [(char=? (string-ref s 0) #\,)
         (loop (substring s 1) 
               stack 
               '() 
               (if (null? current) result (cons current result)))]
        [else
         (let ([end (min (or (string-index s (λ (c) (member c '(#\{ #\} #\,))) (string-length s)) (string-length s))])
           (loop (substring s end)
                 stack
                 (cons (substring s 0 end) current)
                 result))])))

  (define (combine lst)
    (if (null? lst)
        '("")
        (let ([rest (combine (cdr lst))])
          (append-map (λ (x) (map (λ (y) (string-append x y)) rest)) (car lst)))))

  (define (string-index s pred)
    (let loop ([i 0])
      (cond
        [(= i (string-length s)) #f]
        [(pred (string-ref s i)) i]
        [else (loop (+ i 1))])))

  (sort (remove-duplicates (parse expr)) string<?))