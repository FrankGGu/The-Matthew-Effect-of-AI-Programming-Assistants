#lang racket

(define (maximum-removals s p removable)

  ;; Convert removable list to a vector for O(1) access
  (define removable-vec (list->vector removable))
  (define removable-len (vector-length removable-vec))

  (define (is-subsequence-after-removals k)
    ;; k: number of elements to remove from 'removable' array
    (define removed-set (make-hash))
    (for ([i (in-range k)])
      (hash-set! removed-set (vector-ref removable-vec i) #t))

    (define s-len (string-length s))
    (define p-len (string-length p))

    (define s-ptr 0)
    (define p-ptr 0)

    (while (and (< s-ptr s-len) (< p-ptr p-len))
      (when (not (hash-has-key? removed-set s-ptr))
        (when (char=? (string-ref s s-ptr) (string-ref p p-ptr))
          (set! p-ptr (+ p-ptr 1))))
      (set! s-ptr (+ s-ptr 1)))

    (= p-ptr p-len))

  (define low 0)
  (define high removable-len)
  (define ans 0)

  (while (<= low high)
    (define mid (+ low (quotient (- high low) 2)))
    (if (is-subsequence-after-removals mid)
        (begin
          (set! ans mid)
          (set! low (+ mid 1)))
        (set! high (- mid 1))))
  ans)