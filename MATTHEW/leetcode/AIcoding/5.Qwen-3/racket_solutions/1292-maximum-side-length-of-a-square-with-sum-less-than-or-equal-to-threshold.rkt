#lang racket

(define (max-side-length grid threshold)
  (define m (length grid))
  (define n (length (car grid)))
  (define dp (make-vector m (make-vector n 0)))
  (for ([i (in-range m)])
    (for ([j (in-range n)])
      (vector-set! (vector-ref dp i) j
        (+ (if (> i 0) (vector-ref (vector-ref dp (- i 1)) j) 0)
           (if (> j 0) (vector-ref (vector-ref dp i) (- j 1)) 0)
           (if (and (> i 0) (> j 0)) (- (vector-ref (vector-ref dp (- i 1)) (- j 1))) 0)
           (vector-ref (vector-ref grid i) j))))
  (define max-len 0)
  (define (sum i j len)
    (let ([x (+ i len -1)] [y (+ j len -1)])
      (if (or (>= x m) (>= y n)) 0
          (- (vector-ref (vector-ref dp x) y)
             (if (> i 0) (vector-ref (vector-ref dp (- i 1)) y) 0)
             (if (> j 0) (vector-ref (vector-ref dp x) (- j 1)) 0)
             (if (and (> i 0) (> j 0)) (vector-ref (vector-ref dp (- i 1)) (- j 1)) 0)))))
  (define (binary-search low high)
    (if (> low high) max-len
        (let ([mid (quotient (+ low high) 2)])
          (if (and (<= (sum 0 0 mid) threshold))
              (binary-search (+ mid 1) high)
              (binary-search low (- mid 1))))))
  (binary-search 1 (min m n)))