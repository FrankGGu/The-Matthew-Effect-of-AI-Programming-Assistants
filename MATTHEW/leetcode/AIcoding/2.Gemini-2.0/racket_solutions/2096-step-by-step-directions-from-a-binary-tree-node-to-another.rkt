(define (getDirections root startValue destValue)
  (define (find-path root target)
    (cond
      [(null? root) #f]
      [(= (car root) target) '()]
      [else
       (let ([left-path (find-path (cadr root) target)])
         (if left-path
             (cons 'L left-path)
             (let ([right-path (find-path (caddr root) target)])
               (if right-path
                   (cons 'R right-path)
                   #f))))]))

  (define start-path (find-path root startValue))
  (define dest-path (find-path root destValue))

  (define (find-lca start-path dest-path)
    (let loop ([start-path start-path] [dest-path dest-path])
      (cond
        [(or (null? start-path) (null? dest-path) (not (equal? (car start-path) (car dest-path))))
         (values start-path dest-path)]
        [else
         (loop (cdr start-path) (cdr dest-path))])))

  (let-values ([(remaining-start-path remaining-dest-path)] (find-lca start-path dest-path)) )

  (string-append (make-string (length remaining-start-path) #\U)
                 (list->string (map (lambda (x) (cond [(eq? x 'L) #\L] [(eq? x 'R) #\R])) remaining-dest-path))))