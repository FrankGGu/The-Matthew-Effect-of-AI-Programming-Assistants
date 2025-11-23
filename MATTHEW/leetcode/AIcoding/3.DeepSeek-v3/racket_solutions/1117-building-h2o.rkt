#lang racket

(define h2o%
  (class object%
    (super-new)
    (init-field)
    (define semH (make-semaphore 0))
    (define semO (make-semaphore 0))
    (define count 0)

    (define/public (hydrogen)
      (if (= (add1 count) 3)
          (begin
            (set! count 0)
            (semaphore-post semH)
            (semaphore-post semH)
            (semaphore-wait semO))
          (begin
            (set! count (add1 count))
            (semaphore-wait semH))))

    (define/public (oxygen)
      (semaphore-wait semO)
      (semaphore-post semO))))

(define make-H2O (new h2o%))