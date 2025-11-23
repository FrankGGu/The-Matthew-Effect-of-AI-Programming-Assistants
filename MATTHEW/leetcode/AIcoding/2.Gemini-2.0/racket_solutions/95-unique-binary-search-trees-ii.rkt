(define (generate-trees n)
  (define (generate-subtree start end)
    (if (> start end)
        '(#f)
        (let loop ([i start] [result '()])
          (if (> i end)
              result
              (let* ([left-subtrees (generate-subtree start (- i 1))]
                     [right-subtrees (generate-subtree (+ i 1) end)])
                (let loop2 ([left left-subtrees] [result2 '()])
                  (if (null? left)
                      (let loop3 ([right right-subtrees] [result3 result2])
                        (if (null? right)
                            (loop ([+ i 1] (append result3 result))
                            (let ([root (list 'Node (list i) (if (equal? #f (car left-subtrees)) #f (car left-subtrees)) (if (equal? #f (car right)) #f (car right)))]))
                            (loop3 (cdr right) (cons root result3)))))
                      (let loop3 ([right right-subtrees] [result3 result2])
                        (if (null? right)
                            (loop2 (cdr left) (append result3 result2))
                            (let ([root (list 'Node (list i) (if (equal? #f (car left)) #f (car left)) (if (equal? #f (car right)) #f (car right)))]))
                            (loop3 (cdr right) (cons root result3)))))
                  )))))))
  (if (= n 0)
      '()
      (generate-subtree 1 n)))

(define (list->bst l)
  (cond
    [(null? l) #f]
    [else (let ([v (car l)]
                 [rest (cdr l)])
            (cond
              [(equal? v #f) #f]
              [else (cons 'Node (list (car v) (list->bst (cadr v)) (list->bst (caddr v))))]))]))

(define (bst->list tree)
  (cond
    [(equal? tree #f) #f]
    [else (list (car (cadr tree)) (bst->list (caddr tree)) (bst->list (cadddr tree)))]))