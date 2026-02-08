#lang racket

(define (countIncremovableSubarrays arr)
  (define n (length arr))
  (define left (vector 0 n))
  (define right (vector 0 n))

  (for ([i (in-range 1 n)])
    (vector-set! left i (if (>= (vector-ref arr i) (vector-ref arr (sub1 i))) 
                            (vector-ref left (sub1 i)) 
                            i)))

  (for ([i (in-range (- n 2) -1 -1)])
    (vector-set! right i (if (<= (vector-ref arr i) (vector-ref arr (add1 i))) 
                             (vector-ref right (add1 i)) 
                             i)))

  (define count 0)
  (for ([i (in-range n)])
    (define l (vector-ref left i))
    (define r (vector-ref right i))
    (if (and (>= l i) (<= r i))
        (set! count (add1 count))))

  count)