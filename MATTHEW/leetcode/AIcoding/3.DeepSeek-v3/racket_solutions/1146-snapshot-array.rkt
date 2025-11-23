#lang racket

(define snapshot-array%
  (class object%
    (super-new)
    (init-field length)
    (field [snap-id 0]
           [array (make-hash)]
           [snapshots (make-hash)])

    (define/public (set index val)
      (hash-set! array index val))

    (define/public (snap)
      (hash-set! snapshots snap-id (hash-copy array))
      (set! snap-id (add1 snap-id))
      (sub1 snap-id))

    (define/public (get index snap-id)
      (let ([snap (hash-ref snapshots snap-id (hash))])
        (hash-ref snap index 0))))

(define (make-snapshot-array length)
  (new snapshot-array% [length length]))