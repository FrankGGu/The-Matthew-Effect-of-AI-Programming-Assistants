(define (daily-temperatures temperatures)
  (let* ([n (length temperatures)]
         [result (make-vector n 0)]
         [stack '()])
    (for/list ([i (in-range n)])
      (let loop ()
        (cond [(and (not (null? stack))
                    (>= (car (car stack)) (list-ref temperatures i)))
               (set! stack (cons (cons (list-ref temperatures i) i) stack))]
              [(and (not (null? stack))
                    (< (car (car stack)) (list-ref temperatures i)))
               (begin
                 (vector-set! result (cdr (car stack)) (- i (cdr (car stack))))
                 (set! stack (cdr stack))
                 (loop))]
              [else
               (set! stack (cons (cons (list-ref temperatures i) i) stack))]))
      i)
    result))