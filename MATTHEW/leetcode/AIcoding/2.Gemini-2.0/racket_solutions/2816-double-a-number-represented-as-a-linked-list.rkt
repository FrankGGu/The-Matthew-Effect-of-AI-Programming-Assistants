(define (double-a-number head)
  (define (list->number lst)
    (cond [(null? lst) 0]
          [else (+ (* 10 (car lst)) (list->number (cdr lst)))]))

  (define (number->list n)
    (cond [(zero? n) '(0)]
          [else (reverse (let loop ([n n] [acc '()])
                           (if (zero? n)
                               acc
                               (loop (quotient n 10) (cons (remainder n 10) acc)))))]))

  (define (list->linked-list lst)
    (cond [(null? lst) null]
          [else (list* (car lst) (list->linked-list (cdr lst)))]))

  (list->linked-list (number->list (* 2 (list->number (let loop ([head head] [acc '()])
                                                        (if (null? head)
                                                            (reverse acc)
                                                            (loop (cdr head) (cons (car head) acc)))))))))