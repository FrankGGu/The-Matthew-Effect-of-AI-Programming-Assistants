(define (find132pattern nums)
  (let loop ((nums nums)
             (stack '())
             (third -inf.0)
             (first #f))
    (cond
      ((null? nums) #f)
      (else
       (let ((current (car nums)))
         (cond
           ((and (not (null? stack)) (> current third)) #t)
           (else
            (cond
              ((null? stack) (loop (cdr nums) (cons current stack) first))
              ((> current (car stack))
               (set! third (car stack))
               (loop (cdr nums) (cdr stack) third))
              (else (loop (cdr nums) (cons current stack) first)))))))))))

(define (find132pattern nums)
  (let loop ((nums nums)
             (stack '())
             (third -inf.0))
    (if (null? nums)
        #f
        (let ((current (car nums)))
          (if (and (not (null? stack)) (> current third))
              #t
              (begin
                (if (null? stack)
                    (loop (cdr nums) (cons current stack) third)
                    (if (> current (car stack))
                        (begin
                          (set! third (car stack))
                          (loop (cdr nums) (cdr stack) third))
                        (loop (cdr nums) (cons current stack) third))))))))))