#lang racket

(define zero-even-odd%
  (class object%
    (super-new)
    (init-field n)
    (define sema-zero (make-semaphore 1))
    (define sema-odd (make-semaphore 0))
    (define sema-even (make-semaphore 0))

    (define/public (zero print-number)
      (for ([i (in-range 1 (add1 n))])
        (semaphore-wait sema-zero)
        (print-number 0)
        (if (odd? i)
            (semaphore-post sema-odd)
            (semaphore-post sema-even))))

    (define/public (even print-number)
      (for ([i (in-range 2 (add1 n) 2)])
        (semaphore-wait sema-even)
        (print-number i)
        (semaphore-post sema-zero)))

    (define/public (odd print-number)
      (for ([i (in-range 1 (add1 n) 2)])
        (semaphore-wait sema-odd)
        (print-number i)
        (semaphore-post sema-zero))))

(define (make-zero-even-odd n)
  (new zero-even-odd% [n n]))