(define (deleteDuplicates head)
  (if (null? head)
      head
      (begin
        (let ((current head))
          (while (and (not (null? (cdr current))) 
                      (= (val current) (val (cdr current)))))
            (set-cdr! current (cdr (cdr current)))
            (set! current (cdr current)))
          head))))