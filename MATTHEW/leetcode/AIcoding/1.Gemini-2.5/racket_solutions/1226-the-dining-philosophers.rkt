#lang racket

(define dining-philosophers%
  (class object%
    (define forks (make-vector 5))
    (for ([i (in-range 5)])
      (vector-set! forks i (make-semaphore 1)))

    (define arbitrator (make-semaphore 4))

    (define/public (wants-to-eat philosopher-id
                                 pickLeftFork
                                 pickRightFork
                                 eat
                                 putLeftFork
                                 putRightFork)
      (let* ([left-fork-idx philosopher-id]
             [right-fork-idx (modulo (add1 philosopher-id) 5)])

        (semaphore-wait arbitrator)

        (semaphore-wait (vector-ref forks left-fork-idx))
        (pickLeftFork)

        (semaphore-wait (vector-ref forks right-fork-idx))
        (pickRightFork)

        (eat)

        (putRightFork)
        (semaphore-post (vector-ref forks right-fork-idx))

        (putLeftFork)
        (semaphore-post (vector-ref forks left-fork-idx))

        (semaphore-post arbitrator)))

    (super-new)))