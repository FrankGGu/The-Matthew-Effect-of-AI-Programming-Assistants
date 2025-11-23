#lang racket

(require racket/thread)
(require racket/sync)
(require racket/class)

(define foobar%
  (class object%
    (init-field n)
    (field [foo-sem (make-semaphore 1)])
    (field [bar-sem (make-semaphore 0)])

    (define/public (foo printFoo)
      (for ([i (range n)])
        (semaphore-wait foo-sem)
        (printFoo)
        (semaphore-post bar-sem)))

    (define/public (bar printBar)
      (for ([i (range n)])
        (semaphore-wait bar-sem)
        (printBar)
        (semaphore-post foo-sem)))

    (super-new)))