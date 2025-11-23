(define MinStack
  (let ([stack '()]
        [min-stack '()])
    (define (push x)
      (set! stack (cons x stack))
      (set! min-stack (if (null? min-stack)
                          (cons x '())
                          (cons (min x (car min-stack)) min-stack))))

    (define (pop)
      (set! stack (cdr stack))
      (set! min-stack (cdr min-stack)))

    (define (top)
      (car stack))

    (define (getMin)
      (car min-stack))

    (lambda (cmd . args)
      (cond
        [(eq? cmd 'push) (push (car args))]
        [(eq? cmd 'pop) (pop)]
        [(eq? cmd 'top) (top)]
        [(eq? cmd 'getMin) (getMin)]))))