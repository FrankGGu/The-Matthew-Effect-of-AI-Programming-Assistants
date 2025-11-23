(define (isLongPressedName name typed)
  (define (helper n t)
    (cond
      [(and (null? n) (null? t)) #t]
      [(null? t) #f]
      [(and (null? n) (not (null? t))) #f]
      [(equal? (car n) (car t))
       (helper (cdr n) (cdr t))]
      [(equal? (car t) (car (cdr t)))
       (helper n (cdr t))]
      [else #f]))
  (helper (string->list name) (string->list typed)))

(isLongPressedName "alex" "aaleex")
(isLongPressedName "saeed" "ssaaedd")
(isLongPressedName "leelee" "lleeelee")
(isLongPressedName "laiden" "laiden")