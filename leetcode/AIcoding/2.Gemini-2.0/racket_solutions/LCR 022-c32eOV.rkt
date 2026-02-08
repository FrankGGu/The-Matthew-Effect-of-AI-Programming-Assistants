(define (detect-cycle head)
  (let loop ([slow head] [fast head])
    (cond
      [(or (null? fast) (null? (cdr fast))) #f]
      [else
       (let ([slow (cdr slow)] [fast (cddr fast)])
         (cond
           [(eq? slow fast)
            (let loop2 ([ptr head] [meet slow])
              (cond
                [(eq? ptr meet) ptr]
                [else (loop2 (cdr ptr) (cdr meet))]))]
           [else (loop slow fast)]))])))