(define (delete-middle-node head)
  (cond
    [(null? head) head]
    [(null? (cdr head)) #f]
    [else
     (let loop ([slow head] [fast head] [prev #f])
       (cond
         [(or (null? fast) (null? (cdr fast)))
          (cond
            [(null? prev)
             (set! (car head) (car (cdr head)))
             (set-cdr! head (cdr (cdr head)))
             head]
            [else
             (set-cdr! prev (cdr slow))
             head])]
         [else
          (loop (cdr slow) (cdr (cdr fast)) slow)]))]))