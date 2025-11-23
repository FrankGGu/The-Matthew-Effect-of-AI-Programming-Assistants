#lang racket

(struct Solution (m n total-cells current-size flipped-map) #:mutable)

(define (Solution-init m n)
  (define total-cells (* m n))
  (Solution m n total-cells total-cells (make-hash)))

(define (Solution-flip obj)
  (define current-size (Solution-current-size obj))
  (define n (Solution-n obj))
  (define flipped-map (Solution-flipped-map obj))

  (define rand-idx (random current-size))

  (define actual-idx-to-flip
    (hash-table-ref flipped-map rand-idx rand-idx))

  (define actual-idx-at-end
    (hash-table-ref flipped-map (- current-size 1) (- current-size 1)))

  (hash-table-set! flipped-map rand-idx actual-idx-at-end)

  (set-Solution-current-size! obj (- current-size 1))

  (list (quotient actual-idx-to-flip n)
        (remainder actual-idx-to-flip n)))

(define (Solution-reset obj)
  (hash-table-clear! (Solution-flipped-map obj))
  (set-Solution-current-size! obj (Solution-total-cells obj)))