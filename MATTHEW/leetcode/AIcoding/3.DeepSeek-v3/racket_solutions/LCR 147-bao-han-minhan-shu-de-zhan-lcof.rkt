(define min-stack%
  (class object%
    (super-new)
    (init-field)

    (define stack '())
    (define min-stack '())

    (define/public (push x)
      (set! stack (cons x stack))
      (if (or (null? min-stack) (<= x (car min-stack)))
          (set! min-stack (cons x min-stack))
          (void)))

    (define/public (pop)
      (when (not (null? stack))
      (if (equal? (car stack) (car min-stack))
          (set! min-stack (cdr min-stack))
          (void))
      (set! stack (cdr stack)))

    (define/public (top)
      (car stack))

    (define/public (get-min)
      (car min-stack))))