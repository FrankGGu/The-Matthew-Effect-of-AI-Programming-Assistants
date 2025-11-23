(define (is-good nums)
  (define n (length nums))
  (define (check i)
    (if (>= i n)
        #t
        (and (= (list-ref nums i) (add1 i)) (check (add1 i)))))
  (check 0))