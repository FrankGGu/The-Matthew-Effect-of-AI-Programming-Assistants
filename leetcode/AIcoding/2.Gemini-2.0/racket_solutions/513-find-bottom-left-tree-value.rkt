(define (find-bottom-left-value root)
  (let loop ([q (list (cons root 0))]
             [left-most (car (car q))]
             [max-depth 0])
    (if (null? q)
        left-most
        (let* ([curr (car q)]
               [node (car curr)]
               [depth (cdr curr)])
          (let ([new-left-most (if (> depth max-depth)
                                    (car node)
                                    left-most)]
                [new-max-depth (if (> depth max-depth)
                                   depth
                                   max-depth)])
            (loop (append (cdr q)
                          (filter values
                                  (list (and (right node) (cons (right node) (+ depth 1)))
                                        (and (left node) (cons (left node) (+ depth 1))))))
                  new-left-most
                  new-max-depth))))))