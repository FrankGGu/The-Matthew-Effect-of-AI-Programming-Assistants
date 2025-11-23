(define (reinitialize-permutation n)
  (define (next-perm perm)
    (for/vector ([i (in-range n)])
      (if (even? i)
          (vector-ref perm (quotient i 2))
          (vector-ref perm (+ (quotient n 2) (quotient (- i 1) 2))))))

  (let loop ([perm (build-vector n (lambda (i) i))]
             [steps 1])
    (let ([new-perm (next-perm perm)])
      (if (equal? new-perm (build-vector n (lambda (i) i)))
          steps
          (loop new-perm (add1 steps))))))