(define (reverse-even-length-groups head)
  (define (list->list-groups lst k)
    (if (null? lst)
        '()
        (let loop ((lst lst) (curr '()) (count 0))
          (if (or (null? lst) (= count k))
              (cons (reverse curr) (list->list-groups lst k))
              (loop (cdr lst) (cons (car lst) curr) (+ count 1))))))

  (define (reverse-if-even lst)
    (if (even? (length lst))
        (reverse lst)
        lst))

  (define (flatten lst-of-lsts)
    (cond
      [(null? lst-of-lsts) '()]
      [(null? (car lst-of-lsts)) (flatten (cdr lst-of-lsts))]
      [else (append (car lst-of-lsts) (flatten (cdr lst-of-lsts)))]))

  (define (list->linked-list lst)
    (cond
      [(null? lst) #f]
      [else (cons (car lst) (list->linked-list (cdr lst)))]))

  (define (linked-list->list head)
    (if (not head)
        '()
        (cons (car head) (linked-list->list (cdr head)))))

  (define (list->linked-list lst)
    (letrec ((build-list (lambda (lst)
                              (if (null? lst)
                                  #f
                                  (cons (car lst) (build-list (cdr lst)))))))
       (build-list lst)))

  (define groups (list->list-groups (linked-list->list head) 1))
  (define reversed-groups (map reverse-if-even groups))
  (define flattened-list (flatten reversed-groups))
  (list->linked-list flattened-list)
  )