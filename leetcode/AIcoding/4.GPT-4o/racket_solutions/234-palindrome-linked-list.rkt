(define (isPalindrome head)
  (define (reverse-list node)
    (define (helper current prev)
      (if (null? current)
          prev
          (helper (cdr current) (cons (car current) prev))))
    (helper node '()))

  (define (is-equal list1 list2)
    (cond
      [(and (null? list1) (null? list2)) #t]
      [(or (null? list1) (null? list2)) #f]
      [(equal? (car list1) (car list2)) (is-equal (cdr list1) (cdr list2))]
      [else #f]))

  (define slow fast)
  (set! slow head)
  (set! fast head)

  (while (and fast (cdr fast))
    (set! slow (cdr slow))
    (set! fast (cdr (cdr fast))))

  (set! second-half (reverse-list slow))
  (is-equal head second-half))