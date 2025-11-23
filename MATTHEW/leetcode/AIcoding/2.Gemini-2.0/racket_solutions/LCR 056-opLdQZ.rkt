(define (find-target root k)
  (letrec ((bst-to-list
            (lambda (node)
              (if (null? node)
                  '()
                  (append (bst-to-list (bst-node-left node))
                          (list (bst-node-val node))
                          (bst-to-list (bst-node-right node))))))
           (two-sum
            (lambda (nums target)
              (let ((seen (make-hash)))
                (for ([num (in-list nums)])
                  (let ((complement (- target num)))
                    (if (hash-has-key? seen complement)
                        #t
                        (hash-set! seen num #t))))
                #f))))
    (two-sum (bst-to-list root) k)))