#lang racket

(define Stream
  (class object%
    (init)
    (super-new)
    (define/override (hasNext)
      (if (null? this-next)
          #f
          #t))
    (define/override (next)
      (if (null? this-next)
          (error "No more elements")
          (let ((result (car this-next)))
            (set! this-next (cdr this-next))
            result)))
    (define this-next '())
    (define (add x)
      (set! this-next (append this-next (list x))))))

(define FindConsecutiveIntegers
  (class Stream
    (init)
    (super-new)
    (define this-number (make-parameter 0))
    (define this-count (make-parameter 0))
    (define (add x)
      (set! this-count (+ this-count 1))
      (if (= this-count 1)
          (set! this-number x)
          (if (= this-number (+ x -1))
              (set! this-number x)
              (error "Not consecutive"))))
    (define/override (hasNext)
      (if (= this-count 0)
          #f
          #t))
    (define/override (next)
      (if (= this-count 0)
          (error "No more elements")
          (begin
            (set! this-count (- this-count 1))
            this-number))))))

(define (createStream)
  (new FindConsecutiveIntegers))