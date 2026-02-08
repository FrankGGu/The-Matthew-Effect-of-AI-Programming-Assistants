#lang racket

(require racket/hash)
(require racket/random)

(struct RandomizedSet (
    (val->idx #:mutable)
    (vals #:mutable)
    (count #:mutable)
))

(define (RandomizedSet%)
  (RandomizedSet (make-hash) (make-vector 200000 #f) 0))

(define (insert rs val)
  (let ([val->idx (RandomizedSet-val->idx rs)]
        [vals (RandomizedSet-vals rs)]
        [count (RandomizedSet-count rs)])
    (if (hash-has-key? val->idx val)
        #f
        (begin
          (hash-set! val->idx val count)
          (vector-set! vals count val)
          (set-RandomizedSet-count! rs (+ count 1))
          #t))))

(define (remove rs val)
  (let ([val->idx (RandomizedSet-val->idx rs)]
        [vals (RandomizedSet-vals rs)]
        [count (RandomizedSet-count rs)])
    (if (not (hash-has-key? val->idx val))
        #f
        (begin
          (let* ([idx-to-remove (hash-ref val->idx val)]
                 [last-val (vector-ref vals (- count 1))])
            (vector-set! vals idx-to-remove last-val)
            (hash-set! val->idx last-val idx-to-remove)
            (hash-remove! val->idx val)
            (set-RandomizedSet-count! rs (- count 1)))
          #t))))

(define (getRandom rs)
  (let ([vals (RandomizedSet-vals rs)]
        [count (RandomizedSet-count rs)])
    (let ([rand-idx (random count)])
      (vector-ref vals rand-idx))))