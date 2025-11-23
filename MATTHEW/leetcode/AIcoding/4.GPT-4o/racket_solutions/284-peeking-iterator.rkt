(define PeekingIterator
  (lambda (iter)
    (define current-value (iter-next iter))
    (define has-next? (lambda () (iter-has-next iter)))
    (define peek (lambda () current-value))
    (define next (lambda ()
                   (define temp current-value)
                   (if (has-next?)
                       (set! current-value (iter-next iter)))
                   temp))
    (define has-next (lambda () (has-next?)))
    (list 'peek peek 'next next 'has-next has-next)))

(define (iter-next iterator)
  ;; implementation of iter-next
)

(define (iter-has-next iterator)
  ;; implementation of iter-has-next
)