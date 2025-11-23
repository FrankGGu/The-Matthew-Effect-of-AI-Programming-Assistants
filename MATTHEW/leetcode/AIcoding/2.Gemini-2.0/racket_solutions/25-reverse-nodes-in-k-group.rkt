(define (reverse-k-group head k)
  (define (reverse-list head k)
    (cond
      [(= k 0) (values head head)]
      [(null? head) (values head head)]
      [else
       (let-values ([(reversed-rest tail) (reverse-list (cdr head) (- k 1))])
         (if (null? reversed-rest)
             (values head head)
             (begin
               (set-cdr! head tail)
               (values reversed-rest head))))]))

  (define (len head)
    (if (null? head)
        0
        (+ 1 (len (cdr head)))))

  (if (< (len head) k)
      head
      (let-values ([(reversed-head tail) (reverse-list head k)])
        (set-cdr! (car (reverse-list head k)) (reverse-k-group tail k))
        reversed-head)))