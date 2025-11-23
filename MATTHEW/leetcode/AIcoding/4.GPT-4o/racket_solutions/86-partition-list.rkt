(define (partition head x)
  (define less (lambda (node)
                  (if (null? node) 
                      (list '())
                      (cons (car node) (less (cdr node))))))

  (define greater-or-equal (lambda (node)
                              (if (null? node)
                                  (list '())
                                  (cons (car node) (greater-or-equal (cdr node))))))

  (define split-lists (lambda (node)
                        (if (null? node)
                            (values '() '())
                            (let-values ([(less-list greater-list) (split-lists (cdr node))])
                              (if (< (car node) x)
                                  (values (cons (car node) less-list) greater-list)
                                  (values less-list (cons (car node) greater-list)))))))

  (define-values (less-list greater-list) (split-lists head))

  (if (null? less-list)
      greater-list
      (let loop ((node less-list))
        (if (null? (cdr node))
            (append less-list greater-list)
            (loop (cdr node)))))))

(define (ListNode val)
  (list val '()))

(define (list-to-node lst)
  (if (null? lst) 
      '()
      (let ((node (ListNode (car lst))))
        (set-cdr! node (list-to-node (cdr lst)))
        node)))

(define (node-to-list node)
  (if (null? node)
      '()
      (cons (car node) (node-to-list (cdr node)))))