#lang racket

(define (checkPartitioning s)
  (define n (string-length s))
  (define dp (make-vector (add1 n) (make-vector (add1 n) #f)))

  (for ([i (in-range n -1 -1)])
    (for ([j (in-range i n)])
      (if (or (= i j)
              (and (= (string-ref s i) (string-ref s j))
                   (or (= (add1 i) j)
                       (vector-ref (vector-ref dp (add1 i)) (- j 1)))))
          (vector-set! (vector-ref dp i) j #t)
          (vector-set! (vector-ref dp i) j #f))))

  (for ([i (in-range 1 n)])
    (for ([j (in-range (add1 i) n)])
      (if (and (vector-ref (vector-ref dp 0) (- i 1))
               (vector-ref (vector-ref dp i) (- j 1))
               (vector-ref (vector-ref dp j) (- n 1)))
          #t
          #f))
  #f)