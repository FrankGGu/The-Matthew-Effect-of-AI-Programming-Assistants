(define (sort-jumbled-numbers mapping nums)
  (define (key-fn num)
    (let loop ([n num] [k 0])
      (if (= n 0)
          k
          (loop (quotient n 10) (+ (* (list-ref mapping (remainder n 10)) (expt 10 k)) k)))))
  (sort nums (lambda (a b) (< (key-fn a) (key-fn b)))))