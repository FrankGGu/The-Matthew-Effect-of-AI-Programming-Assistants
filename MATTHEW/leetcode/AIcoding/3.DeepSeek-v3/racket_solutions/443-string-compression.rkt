(define/contract (compress chars)
  (-> (listof char?) exact-integer?)
  (let loop ([chars chars] [result '()] [count 1] [prev #f])
    (cond
      [(null? chars)
       (let* ([result (if (zero? count) result (cons prev result))]
              [result (if (<= count 1) result (append (reverse (string->list (number->string count))) result))])
       (set! chars (reverse result))
       (length chars)]
      [(equal? prev (car chars))
       (loop (cdr chars) result (add1 count) prev)]
      [else
       (let ([new-result (if (zero? count) result (cons prev result))]
            [new-result (if (<= count 1) new-result (append (reverse (string->list (number->string count))) new-result))]))
        (loop (cdr chars) new-result 1 (car chars)))])))