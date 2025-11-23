(define (trainning-plan nums)
  (define (helper lst res)
    (if (null? lst)
        res
        (helper (cdr lst) (append res (list (car lst))))))
  (helper nums '()))