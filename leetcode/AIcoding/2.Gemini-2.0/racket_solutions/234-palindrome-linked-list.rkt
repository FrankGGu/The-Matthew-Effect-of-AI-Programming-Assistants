(define (is-palindrome? head)
  (define (list->vector lst)
    (list->vector lst))

  (define (reverse-list lst)
    (reverse lst))

  (define (list-equal? lst1 lst2)
    (equal? lst1 lst2))

  (if (null? head)
      #t
      (let* ([lst (list->vector (list head (cdr head) (cddr head) (cdddr head) (cddddr head)))]
             [reversed-lst (reverse-list lst)])
        (list-equal? lst reversed-lst))))