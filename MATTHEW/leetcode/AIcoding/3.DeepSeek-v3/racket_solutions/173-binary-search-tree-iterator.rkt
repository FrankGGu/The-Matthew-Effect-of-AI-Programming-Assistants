#lang racket

(define bst-iterator%
  (class object%
    (super-new)

    (init-field root)

    (define stack '())

    (define (push-all node)
      (let loop ([node node])
        (unless (null? node)
          (set! stack (cons node stack))
          (loop (send node get-left)))))

    (push-all root)

    (define/public (next)
      (let ([node (car stack)])
        (set! stack (cdr stack))
        (push-all (send node get-right))
        (send node get-val)))

    (define/public (has-next)
      (not (null? stack)))))

(define (make-iterator root)
  (new bst-iterator% [root root]))