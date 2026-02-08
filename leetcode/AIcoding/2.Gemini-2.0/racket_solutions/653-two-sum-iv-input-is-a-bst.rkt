(define (find-target root k)
  (letrec (
           (tree->list
            (lambda (node)
              (if (null? node)
                  '()
                  (append (tree->list (bst-left node))
                          (list (bst-val node))
                          (tree->list (bst-right node))))))
           (find-pair
            (lambda (lst k)
              (let loop ((left 0) (right (- (length lst) 1)))
                (cond
                  ((>= left right) #f)
                  ((= (+ (list-ref lst left) (list-ref lst right)) k) #t)
                  ((> (+ (list-ref lst left) (list-ref lst right)) k) (loop left (- right 1)))
                  (else (loop (+ left 1) right)))))))
    (find-pair (tree->list root) k)))