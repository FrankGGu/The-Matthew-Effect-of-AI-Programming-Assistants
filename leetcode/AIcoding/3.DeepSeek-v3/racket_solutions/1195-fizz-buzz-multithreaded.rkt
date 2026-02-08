#lang racket

(define fizz-buzz%
  (class object%
    (super-new)
    (init-field (n 0))
    (define current 1)
    (define lock (make-semaphore 1))
    (define cv-f (make-semaphore 0))
    (define cv-b (make-semaphore 0))
    (define cv-fb (make-semaphore 0))
    (define cv-n (make-semaphore 0))

    (define/public (fizz printFizz)
      (let loop ()
        (semaphore-wait cv-f)
        (when (<= current n)
          (printFizz)
          (set! current (add1 current))
          (signal-next)
          (loop))))

    (define/public (buzz printBuzz)
      (let loop ()
        (semaphore-wait cv-b)
        (when (<= current n)
          (printBuzz)
          (set! current (add1 current))
          (signal-next)
          (loop))))

    (define/public (fizzbuzz printFizzBuzz)
      (let loop ()
        (semaphore-wait cv-fb)
        (when (<= current n)
          (printFizzBuzz)
          (set! current (add1 current))
          (signal-next)
          (loop))))

    (define/public (number printNumber)
      (let loop ()
        (semaphore-wait cv-n)
        (when (<= current n)
          (printNumber current)
          (set! current (add1 current))
          (signal-next)
          (loop))))

    (define (signal-next)
      (semaphore-wait lock)
      (cond
        [(> current n)
         (semaphore-post cv-f)
         (semaphore-post cv-b)
         (semaphore-post cv-fb)
         (semaphore-post cv-n)]
        [(and (zero? (modulo current 3)) (zero? (modulo current 5)))
         (semaphore-post cv-fb)]
        [(zero? (modulo current 3))
         (semaphore-post cv-f)]
        [(zero? (modulo current 5))
         (semaphore-post cv-b)]
        [else
         (semaphore-post cv-n)])
      (semaphore-post lock)))

    (signal-next)))