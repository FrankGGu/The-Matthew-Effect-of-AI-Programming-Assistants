#lang racket

(define (get-kth-largest-xor-coordinate-value grid-list k)
  (define m (length grid-list))
  (define n (length (car grid-list)))

  (define grid (build-vector m (lambda (i) (list->vector (list-ref grid-list i)))))

  (define dp (build-vector m (lambda (i) (make-vector n 0))))

  (define xor-values '())

  (for ([i (in-range m)])
    (for ([j (in-range n)])
      (define current-val (vector-ref (vector-ref grid i) j))
      (define val 0)

      (cond
        ((and (= i 0) (= j 0))
         (set! val current-val))
        ((= i 0)
         (set! val (bitwise-xor (vector-ref (vector-ref dp i) (- j 1)) current-val)))
        ((= j 0)
         (set! val (bitwise-xor (vector-ref (vector-ref dp (- i 1)) j) current-val)))
        (else
         (set! val (bitwise-xor
                     (vector-ref (vector-ref dp (- i 1)) j)
                     (vector-ref (vector-ref dp i) (- j 1))
                     (bitwise-xor (vector-ref (vector-ref dp (- i 1)) (- j 1)) current-val))))
        )

      (vector-set! (vector-ref dp i) j val)
      (set! xor-values (cons val xor-values))))

  (define sorted-xor-values (sort xor-values >))

  (list-ref sorted-xor-values (- k 1)))