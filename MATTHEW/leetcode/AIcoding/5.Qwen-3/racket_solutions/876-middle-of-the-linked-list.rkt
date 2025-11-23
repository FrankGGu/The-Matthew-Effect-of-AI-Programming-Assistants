(define (middle-node head)
  (let loop ((slow head) (fast head))
    (if (or (null? fast) (null? (cdr fast)))
        slow
        (loop (cdr slow) (cddr fast)))))