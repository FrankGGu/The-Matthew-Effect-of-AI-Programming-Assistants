#lang racket

(define/contract (longest-special-path parents s)
  (-> (listof exact-integer?) string? exact-integer?)
  (define n (length parents))
  (define adj (make-vector n '()))
  (for ([i (in-range n)]
        [p parents])
    (when (>= p 0)
      (vector-set! adj p (cons i (vector-ref adj p)))))

  (define res 0)

  (define (dfs u)
    (define max1 0)
    (define max2 0)
    (for ([v (vector-ref adj u)])
      (define len (dfs v))
      (if (not (eq? (string-ref s u) (string-ref s v)))
          (if (> len max1)
              (begin
                (set! max2 max1)
                (set! max1 len))
              (when (> len max2)
                (set! max2 len)))
          (void)))
    (set! res (max res (+ max1 max2 1)))
    (+ max1 1))

  (for ([i (in-range n)])
    (when (= (list-ref parents i) -1)
      (dfs i))
  res)