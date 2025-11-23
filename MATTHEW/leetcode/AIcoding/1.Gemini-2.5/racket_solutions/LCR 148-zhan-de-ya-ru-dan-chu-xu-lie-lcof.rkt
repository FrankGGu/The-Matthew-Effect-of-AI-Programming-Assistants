(define (validate-stack-sequences pushed popped)
  (let loop ((pushed-list pushed)
             (popped-list popped)
             (stack '()))
    (cond
      ((empty? pushed-list)
       (empty? stack))
      (else
       (let* ((current-push (car pushed-list))
              (next-pushed-list (cdr pushed-list))
              (new-stack (cons current-push stack)))
         (let pop-loop ((current-stack new-stack)
                        (current-popped popped-list))
           (cond
             ((or (empty? current-stack) (empty? current-popped))
              (loop next-pushed-list current-popped current-stack))
             ((= (car current-stack) (car current-popped))
              (pop-loop (cdr current-stack) (cdr current-popped)))
             (else
              (loop next-pushed-list current-popped current-stack))))))))