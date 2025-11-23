(define (remove-subfolders folder)
  (let* ([sorted-folders (sort folder string<?)]
         [result (list)]
         [root-set (set)])
    (for ([f sorted-folders])
      (let loop ([path f] [parts (string-split path "/")])
        (cond
          [(null? parts) #f]
          [(set-member? root-set path) #f]
          [(null? (cdr parts))
           (begin
             (set-add! root-set f)
             (set! result (cons f result))
             #t)]
          [else
           (let ([parent (string-join (take parts (- (length parts) 1)) "/")])
             (loop parent (take parts (- (length parts) 1))))])))
    (reverse result)))