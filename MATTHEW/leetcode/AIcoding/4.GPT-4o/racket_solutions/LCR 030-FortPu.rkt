#lang racket

(define RandomizedCollection
  (class object%
    (define/override (init)
      (super-new)
      (set! items (make-hash))
      (set! index (vector))
      (set! rand (make-random-source)))

    (define items (make-parameter (hash)))
    (define index (make-parameter (vector)))
    (define rand (make-parameter (make-random-source)))

    (define/public (insert val)
      (hash-set! (items) val (add1 (hash-ref (items) val 0)))
      (vector-set! (index) (vector-length (index)) val))

    (define/public (remove val)
      (when (hash-ref (items) val 0)
        (hash-set! (items) val (sub1 (hash-ref (items) val)))
        (for ([i (in-range (vector-length (index)))])
          (when (equal? (vector-ref (index) i) val)
            (vector-set! (index) i (vector-ref (index) (sub1 (vector-length (index))))))
            (vector-set! (index) (sub1 (vector-length (index))) #f)))
        (hash-set! (items) val (max 0 (hash-ref (items) val)))))

    (define/public (getRandom)
      (vector-ref (index) (random (vector-length (index)))))))

(define myCollection (new RandomizedCollection))

(send myCollection insert 1)
(send myCollection insert 1)
(send myCollection insert 2)
(send myCollection remove 1)
(send myCollection getRandom)