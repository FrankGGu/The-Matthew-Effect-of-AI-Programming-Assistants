(define (num-perm-di(seq))
  (define n (+ (length seq) 1))
  (define dp (make-vector (add1 n) (make-vector (add1 n) 0)))
  (vector-set! dp 0 1)

  (for ([i (in-range n)])
    (for ([j (in-range (add1 i))])
      (if (eq? (string-ref seq i) #\D)
          (vector-set! dp (add1 i) j (vector-ref dp i j))
          (vector-set! dp (add1 i) j (+ (vector-ref dp i j) (vector-ref dp i (sub1 j))))))
      (if (eq? (string-ref seq i) #\I)
          (vector-set! dp (add1 i) j (+ (vector-ref dp i j) (vector-ref dp i (sub1 j))))))
    )
  )

  (vector-ref dp n n))

(num-perm-di "DID")  ; Example usage