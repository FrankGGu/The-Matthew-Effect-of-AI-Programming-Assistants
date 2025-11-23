(define (is-palindrome head)
  (define (list-to-vector lst)
    (list->vector lst))

  (define (vector-palindrome? v)
    (define len (vector-length v))
    (let loop ([i 0])
      (cond [(>= i (quotient len 2)) #t]
            [(= (vector-ref v i) (vector-ref v (- len i 1))) (loop (+ i 1))]
            [else #f])))

  (define (list->list lst)
    (cond [(null? lst) '()]
          [else (cons (car lst) (list->list (cdr lst)))]))

  (define (linked-list->list head)
    (cond [(null? head) '()]
          [else (cons (cond [(pair? head) (car head)]
                            [else head])
                     (linked-list->list (cond [(pair? head) (cdr head)]
                                              [else null?])))]))

  (vector-palindrome? (list-to-vector (linked-list->list head))))