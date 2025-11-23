#lang racket

(define (min-trio-degree n edges)
  (define adj (make-vector (+ n 1) #f)) ; Adjacency matrix representation
  (define degrees (make-vector (+ n 1) 0))

  ;; Initialize adjacency matrix with vectors of booleans
  (for ([i (in-range (+ n 1))])
    (vector-set! adj i (make-vector (+ n 1) #f)))

  ;; Populate adjacency matrix and calculate degrees
  (for ([edge edges])
    (define u (car edge))
    (define v (cadr edge))
    (vector-set! (vector-ref adj u) v #t)
    (vector-set! (vector-ref adj v) u #t)
    (vector-set! degrees u (+ (vector-ref degrees u) 1))
    (vector-set! degrees v (+ (vector-ref degrees v) 1)))

  (define min-degree +inf.0)

  ;; Iterate through all possible combinations of three distinct nodes (i, j, k)
  ;; ensuring i < j < k to avoid duplicates and self-loops
  (for ([i (in-range 1 (+ n 1))])
    (for ([j (in-range (+ i 1) (+ n 1))])
      (for ([k (in-range (+ j 1) (+ n 1))])
        ;; Check if (i, j, k) form a connected trio (triangle)
        (when (and (vector-ref (vector-ref adj i) j) ; Edge (i, j) exists
                   (vector-ref (vector-ref adj j) k) ; Edge (j, k) exists
                   (vector-ref (vector-ref adj i) k)) ; Edge (i, k) exists
          ;; Calculate the degree of the current trio
          ;; Sum of degrees of nodes i, j, k minus 6 (each of the 3 trio edges counted twice)
          (define current-trio-degree
            (- (+ (vector-ref degrees i)
                  (vector-ref degrees j)
                  (vector-ref degrees k))
               6))
          ;; Update minimum degree found so far
          (set! min-degree (min min-degree current-trio-degree))))))

  ;; If no trio was found, min-degree remains +inf.0, return -1
  (if (= min-degree +inf.0)
      -1
      min-degree))