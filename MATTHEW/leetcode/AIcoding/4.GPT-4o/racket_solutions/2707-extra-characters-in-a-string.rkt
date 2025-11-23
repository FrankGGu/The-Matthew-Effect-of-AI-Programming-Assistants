(define (min-extra-characters s dictionary)
  (define n (string-length s))
  (define dp (make-vector (add1 n) +inf.0))
  (vector-set! dp 0 0)
  (define dict-set (set (map string->symbol dictionary)))

  (define (check-word start end)
    (set-member? dict-set (substring s start end)))

  (for ([i (in-range n)])
    (for ([j (in-range i +1)])
      (if (check-word j (add1 i))
          (vector-set! dp (add1 i) (min (vector-ref dp (add1 i)) (vector-ref dp j)))
          (vector-set! dp (add1 i) (add1 (vector-ref dp (add1 i))))))
    (vector-set! dp (add1 i) (min (vector-ref dp (add1 i)) (add1 (vector-ref dp i)))))

  (vector-ref dp n))

(define (min-extra-characters-wrapper s dictionary)
  (min-extra-characters s dictionary))