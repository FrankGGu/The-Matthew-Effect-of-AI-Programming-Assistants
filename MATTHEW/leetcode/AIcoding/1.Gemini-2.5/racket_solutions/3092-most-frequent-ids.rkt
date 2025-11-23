#lang racket

(require racket/hash)
(require racket/rbtrees)

(define (most-frequent-ids nums freqs)
  (define n (vector-length nums))
  (define id-freqs (make-hash))
  (define freq-counts (rbtree))
  (define ans (make-vector n))

  (for ([i (in-range n)])
    (define id (vector-ref nums i))
    (define delta-freq (vector-ref freqs i))

    (define old-freq (hash-ref id-freqs id 0))

    (when (> old-freq 0)
      (define old-freq-count (rbtree-ref freq-counts old-freq))
      (define new-old-freq-count (- old-freq-count 1))
      (set! freq-counts
            (if (= new-old-freq-count 0)
                (rbtree-remove freq-counts old-freq)
                (rbtree-set freq-counts old-freq new-old-freq-count))))

    (define new-freq (+ old-freq delta-freq))

    (hash-set! id-freqs id new-freq)

    (when (> new-freq 0)
      (define new-freq-count (rbtree-ref freq-counts new-freq 0))
      (set! freq-counts (rbtree-set freq-counts new-freq (+ new-freq-count 1))))

    (vector-set! ans i
                 (if (rbtree-empty? freq-counts)
                     0
                     (rbtree-max-key freq-counts))))
  ans)