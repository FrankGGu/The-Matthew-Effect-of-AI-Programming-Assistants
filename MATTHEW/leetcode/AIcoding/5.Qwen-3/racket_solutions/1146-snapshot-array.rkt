#lang racket

(define (make-snapshot-array length)
  (let ([data (make-hash)]
        [snap-id 0]
        [snapshots (list (hash))]
        [default-val 0])
    (define (get index snap-id)
      (if (hash-has-key? (hash-ref data index) snap-id)
          (hash-ref (hash-ref data index) snap-id)
          default-val))
    (define (set index val)
      (hash-set! (hash-ref data index) snap-id val))
    (define (snap)
      (set! snap-id (+ snap-id 1))
      (set! snapshots (cons (hash-copy (hash-ref data index)) snapshots))
      (- snap-id 1))
    (define (get-snapshot snapshot-id index)
      (if (>= snapshot-id (length snapshots))
          default-val
          (hash-ref (list-ref snapshots snapshot-id) index default-val)))
    (lambda (cmd . args)
      (cond [(equal? cmd 'get) (get (car args) (cadr args))]
            [(equal? cmd 'set) (set (car args) (cadr args))]
            [(equal? cmd 'snap) (snap)]))))

(define (main)
  (let ([arr (make-snapshot-array 3)])
    (arr 'set 0 5)
    (arr 'snap)
    (arr 'set 0 6)
    (arr 'snap)
    (arr 'get 0 0)
    (arr 'get 0 1)
    (arr 'get 0 2)))

(main)