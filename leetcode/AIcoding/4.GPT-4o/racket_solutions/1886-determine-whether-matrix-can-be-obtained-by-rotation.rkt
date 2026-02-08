#lang racket

(define (canBeObtainedByRotation A B)
  (define (rotate m)
    (define n (length m))
    (for/list ([i (in-range n)])
      (for/list ([j (in-range n)])
        (vector-ref (vector-ref m (- n j 1)) i))))

  (define (equal-matrix m1 m2)
    (and (= (length m1) (length m2))
         (for/and ([i (in-range (length m1))])
           (equal? (vector->list (vector-ref m1 i))
                   (vector->list (vector-ref m2 i))))))

  (or (equal-matrix A B)
      (equal-matrix A (rotate A))
      (equal-matrix A (rotate (rotate A)))
      (equal-matrix A (rotate (rotate (rotate A)))))

)