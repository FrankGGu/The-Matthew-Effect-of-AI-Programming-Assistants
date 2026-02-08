(define (insert list insertVal)
  (cond
    [(null? list) (list (list insertVal))]
    [(null? (cdr list)) (list (list insertVal))]
    [else
     (let loop ([current list] [prev null])
       (cond
         [(and (<= insertVal (caar current)) (> insertVal (caar (last list)))) (cons (list insertVal) current)]
         [(and (<= insertVal (caar current)) (>= insertVal (caar prev))) (cons (list insertVal) current)]
         [(and (> insertVal (caar current)) (null? (cdr current))) (append current (list (list insertVal)))]
         [else (loop (cdr current) current)]))]))