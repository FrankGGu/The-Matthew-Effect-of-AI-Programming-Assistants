(define (words-within-two-edits dictionary query)
  (define (diff s1 s2)
    (let loop ([s1 (string->list s1)] [s2 (string->list s2)] [count 0])
      (cond
        [(empty? s1) count]
        [(equal? (car s1) (car s2)) (loop (cdr s1) (cdr s2) count)]
        [else (loop (cdr s1) (cdr s2) (+ count 1))])))

  (filter (lambda (d) (<= (diff query d) 2)) dictionary))