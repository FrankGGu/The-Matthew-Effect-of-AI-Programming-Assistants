(define (decode-rlen lst)
  (cond ((null? lst) '())
        (else
         (let* ((count (car lst))
                (val (cadr lst))
                (rest (cddr lst)))
           (append (make-list count val)
                   (decode-rlen rest))))))