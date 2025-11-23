(define (can-type-all-words words broken-letters)
  (let ([broken-letters-set (set)])
    (for ([c (in-string broken-letters)])
      (set-add! broken-letters-set c))
    (let loop ([words words] [count 0])
      (cond
        [(null? words) count]
        [else
         (let ([word (car words)])
           (if (ormap (lambda (c) (set-member? broken-letters-set c)) (string->list word))
               (loop (cdr words) count)
               (loop (cdr words) (+ count 1))))]))))