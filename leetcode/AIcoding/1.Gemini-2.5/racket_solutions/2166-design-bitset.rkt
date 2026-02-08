#lang racket

(struct Bitset (size
                set-indices
                unset-indices
                is-flipped?)
        #:mutable)

(define (Bitset-constructor size)
  (define initial-unset-indices (make-hash-set))
  (for ([i (in-range size)])
    (hash-set-add! initial-unset-indices i))
  (Bitset size (make-hash-set) initial-unset-indices #f))

(define (fix bs index)
  (define current-set-indices (Bitset-set-indices bs))
  (define current-unset-indices (Bitset-unset-indices bs))
  (cond
    [(Bitset-is-flipped? bs)
     (when (hash-set-remove! current-set-indices index)
       (hash-set-add! current-unset-indices index))]
    [else
     (when (hash-set-remove! current-unset-indices index)
       (hash-set-add! current-set-indices index))]))

(define (unfix bs index)
  (define current-set-indices (Bitset-set-indices bs))
  (define current-unset-indices (Bitset-unset-indices bs))
  (cond
    [(Bitset-is-flipped? bs)
     (when (hash-set-remove! current-unset-indices index)
       (hash-set-add! current-set-indices index))]
    [else
     (when (hash-set-remove! current-set-indices index)
       (hash-set-add! current-unset-indices index))]))

(define (flip bs)
  (set-Bitset-is-flipped?! bs (not (Bitset-is-flipped? bs))))

(define (all bs)
  (define current-size (Bitset-size bs))
  (cond
    [(Bitset-is-flipped? bs)
     (= (hash-set-count (Bitset-unset-indices bs)) current-size)]
    [else
     (= (hash-set-count (Bitset-set-indices bs)) current-size)]))

(define (one bs)
  (cond
    [(Bitset-is-flipped? bs)
     (> (hash-set-count (Bitset-unset-indices bs)) 0)]
    [else
     (> (hash-set-count (Bitset-set-indices bs)) 0)]))

(define (count bs)
  (cond
    [(Bitset-is-flipped? bs)
     (hash-set-count (Bitset-unset-indices bs))]
    [else
     (hash-set-count (Bitset-set-indices bs))]))

(define (toString bs)
  (define current-size (Bitset-size bs))
  (define char-vec (make-vector current-size #\0))
  (define current-set-indices (Bitset-set-indices bs))

  (cond
    [(Bitset-is-flipped? bs)
     (define current-unset-indices (Bitset-unset-indices bs))
     (for ([idx (in-hash-set current-unset-indices)])
       (vector-set! char-vec idx #\1))]
    [else
     (for ([idx (in-hash-set current-set-indices)])
       (vector-set! char-vec idx #\1))])
  (vector->string char-vec))