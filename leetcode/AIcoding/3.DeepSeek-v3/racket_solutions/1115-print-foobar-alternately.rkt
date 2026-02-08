#lang racket

(define foo-bar%
  (class object%
    (super-new)
    (init-field n)
    (define sema-foo (make-semaphore 1))
    (define sema-bar (make-semaphore 0))

    (define/public (foo printFoo)
      (for ([i (in-range n)])
        (semaphore-wait sema-foo)
        (printFoo)
        (semaphore-post sema-bar)))

    (define/public (bar printBar)
      (for ([i (in-range n)])
        (semaphore-wait sema-bar)
        (printBar)
        (semaphore-post sema-foo)))))