(define (min-removal nums)
  (define n (length nums))
  (define dp (make-vector (add1 n) 0))

  (for ([i (in-range 1 (add1 n))])
    (vector-set! dp i (add1 (vector-ref dp (sub1 i))))
    (for ([j (in-range 0 i)])
      (when (<= (vector-ref nums j) (vector-ref nums (sub1 i)))
        (vector-set! dp i (min (vector-ref dp i) (vector-ref dp j))))))

  (- n (vector-ref dp n)))