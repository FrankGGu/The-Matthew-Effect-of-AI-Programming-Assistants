#lang racket

(define (longest-special-path parents s)
  (define n (length parents))
  (define adj (make-vector n '()))
  (for ([i (in-range 1 n)])
    (define p (list-ref parents i))
    (vector-set! adj p (cons i (vector-ref adj p))))

  (define max-len 0)

  (define (dfs u)
    (define max1 0)
    (define max2 0)
    (for ([v (vector-ref adj u)])
      (define len (dfs v))
      (if (not (eq? (string-ref s u) (string-ref s v)))
          (begin
            (if (> len max1)
                (begin
                  (set! max2 max1)
                  (set! max1 len))
                (when (> len max2)
                  (set! max2 len)))
            (set! max-len (max max-len (+ max1 max2 1))))
          (void)))
    (+ max1 1))

  (dfs 0)
  max-len)