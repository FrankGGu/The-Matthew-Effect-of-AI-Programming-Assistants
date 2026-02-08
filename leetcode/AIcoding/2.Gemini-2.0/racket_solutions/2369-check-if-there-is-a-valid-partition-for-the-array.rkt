(define (valid-partition nums)
  (define n (length nums))
  (define dp (make-vector (+ n 1) #f))
  (vector-set! dp 0 #t)
  (for ([i (in-range 1 (+ n 1))])
    (cond
      [(and (>= i 2) (= (list-ref nums (- i 1)) (list-ref nums (- i 2))) (vector-ref dp (- i 2)))
       (vector-set! dp i #t)]
      [(and (>= i 3)
            (= (list-ref nums (- i 1)) (list-ref nums (- i 2)))
            (= (list-ref nums (- i 2)) (list-ref nums (- i 3)))
            (vector-ref dp (- i 3)))
       (vector-set! dp i #t)]
      [(and (>= i 3)
            (= (+ 1 (list-ref nums (- i 2))) (list-ref nums (- i 1)))
            (= (+ 1 (list-ref nums (- i 3))) (list-ref nums (- i 2)))
            (vector-ref dp (- i 3)))
       (vector-set! dp i #t)]))
  (vector-ref dp n))