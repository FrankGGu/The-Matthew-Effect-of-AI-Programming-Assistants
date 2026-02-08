(define (detect-cycle head)
  (let loop ((slow head) (fast head))
    (cond
      [(or (null? fast) (null? (cdr fast))) #f]
      [else
       (let ((new-slow (cdr slow)) (new-fast (cddr fast)))
         (cond
           [(equal? new-slow new-fast)
            (let loop2 ((ptr head) (intersect new-slow))
              (cond
                [(equal? ptr intersect) ptr]
                [else (loop2 (cdr ptr) (cdr intersect))]))]
           [else (loop new-slow new-fast)]))])))