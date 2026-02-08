#lang racket

(define MinStack
  (class object%
    (define/override (init)
      (super-new)
      (set! stack '())
      (set! min-stack '()))

    (define (push x)
      (set! stack (cons x stack))
      (if (or (null? min-stack) (< x (car min-stack)))
          (set! min-stack (cons x min-stack))
          (set! min-stack (cons (car min-stack) min-stack))))

    (define (pop)
      (when (not (null? stack))
        (set! stack (cdr stack))
        (set! min-stack (cdr min-stack))))

    (define (top)
      (car stack))

    (define (getMin)
      (car min-stack))

    (define/public (push x)
      (push x))

    (define/public (pop)
      (pop))

    (define/public (top)
      (top))

    (define/public (getMin)
      (getMin))))

(define minStack (new MinStack))