(define (delete-leaves root target)
  (cond
    [(null? root) null]
    [else
     (let* ([left (delete-leaves (car root) target)]
            [right (delete-leaves (cdr root) target)])
       (set-car! root left)
       (set-cdr! root right)
       (if (and (= (car root) null) (= (cdr root) null) (= (caddr root) target))
           null
           root))]))

(define (delete-leaves-wrapper root target)
  (if (null? root)
      null
      (let ([new-root (delete-leaves root target)])
        new-root)))