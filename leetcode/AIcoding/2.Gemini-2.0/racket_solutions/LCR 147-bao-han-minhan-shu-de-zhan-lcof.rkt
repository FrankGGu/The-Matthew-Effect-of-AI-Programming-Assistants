(define stack%
  (class object%
    (init-field data)
    (init-field min-stack)
    (define/public (push x)
      (set! data (cons x data))
      (if (or (empty? min-stack) (<= x (car min-stack)))
          (set! min-stack (cons x min-stack))))
    (define/public (pop)
      (define top (car data))
      (set! data (cdr data))
      (if (= top (car min-stack))
          (set! min-stack (cdr min-stack))))
    (define/public (top)
      (car data))
    (define/public (get-min)
      (car min-stack))
    (super-new)
    (set! data '())
    (set! min-stack '())))

(define MinStack
  (lambda () (new stack%)))