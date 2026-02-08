(define/contract (decorate-record root)
  (-> (or/c #f list?) (listof (listof exact-integer?)))
  (if (null? root)
      '()
      (let loop ([queue (list root)]
                 [res '()])
        (if (null? queue)
            (reverse res)
            (let* ([level (map (lambda (node) (car node)) queue)]
                   [next-queue (append-map 
                                (lambda (node) 
                                  (filter (lambda (x) (not (null? x)))
                                          (list (cadr node) (caddr node))))
                                queue)])
              (loop next-queue (cons level res)))))))