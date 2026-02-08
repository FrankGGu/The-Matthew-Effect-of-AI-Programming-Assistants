(define (print-in-order)
  (let* ((first-done (make-semaphore 0))
         (second-done (make-semaphore 0)))
    (define (first (printFirst))
      (printFirst)
      (semaphore-post first-done))

    (define (second (printSecond))
      (semaphore-wait first-done)
      (printSecond)
      (semaphore-post second-done))

    (define (third (printThird))
      (semaphore-wait second-done)
      (printThird))

    (define (constructor)
      (define (first* (printFirst))
        (future (lambda () (first printFirst))))
      (define (second* (printSecond))
        (future (lambda () (second printSecond))))
      (define (third* (printThird))
        (future (lambda () (third printThird))))

      (define (await-all)
          (void))

      (define (first printFirst)
        (first* printFirst))

      (define (second printSecond)
        (second* printSecond))

      (define (third printThird)
        (third* printThird))

      (list first second third await-all))
    constructor)))