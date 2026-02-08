(define (MyStack)
  (define queue1 (list))
  (define queue2 (list))

  (define (push x)
    (set! queue2 (cons x queue2))
    (for-each (lambda (y) (set! queue2 (append queue2 (list y)))) queue1)
    (set! queue1 queue2)
    (set! queue2 (list)))

  (define (pop)
    (if (null? queue1)
        (error "Stack is empty"))
    (define val (car queue1))
    (set! queue1 (cdr queue1))
    val)

  (define (top)
    (if (null? queue1)
        (error "Stack is empty"))
    (car queue1))

  (define (empty?)
    (null? queue1))

  (define (get-operations)
    (list push pop top empty?))

  (get-operations))