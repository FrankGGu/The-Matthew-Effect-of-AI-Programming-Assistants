#lang racket

(define TimeMap
  (class object%
    (super-new)
    (define/override (init)
      (set! data (make-hash))
      (set! timestamps (make-hash)))

    (define data (make-parameter (make-hash)))
    (define timestamps (make-parameter (make-hash)))

    (define (set key value timestamp)
      (define entries (hash-ref (data) key (list)))
      (define new-entries (cons (cons timestamp value) entries))
      (hash-set! (data) key new-entries))

    (define (get key timestamp)
      (define entries (hash-ref (data) key '()))
      (define sorted-entries (sort entries (λ (a b) (< (car a) (car b)))))
      (define result (for/fold ([res #f]) ([entry sorted-entries])
                       (if (and (<= (car entry) timestamp) (or (not res) (> (car entry) (car res))))
                           entry
                           res)))
      (if result (cdr result) #f))

    (define/public (set key value timestamp)
      (set key value timestamp))

    (define/public (get key timestamp)
      (get key timestamp))))

(define timeMap (new TimeMap))