(define (flipEquiv root1 root2)
  (cond
    [(and (null? root1) (null? root2)) #t]
    [(or (null? root1) (null? root2)) #f]
    [(= (car root1) (car root2))
     (or (and (flipEquiv (cadr root1) (cadr root2))
              (flipEquiv (caddr root1) (caddr root2)))
         (and (flipEquiv (cadr root1) (caddr root2))
              (flipEquiv (caddr root1) (cadr root2))))]
    [else #f]))