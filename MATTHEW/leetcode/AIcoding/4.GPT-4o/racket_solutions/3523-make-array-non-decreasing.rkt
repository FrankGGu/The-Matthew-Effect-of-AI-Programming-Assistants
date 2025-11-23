(define (checkPossibility nums)
  (define count 0)
  (define (helper i)
    (if (>= i (sub1 (length nums)))
        #t
        (if (<= (list-ref nums i) (list-ref nums (add1 i)))
            (helper (add1 i))
            (begin
              (set! count (add1 count))
              (if (> count 1)
                  #f
                  (begin
                    (if (i = 0)
                        (helper (add1 i))
                        (if (>= (list-ref nums (sub1 i)) (list-ref nums (add1 i)))
                            (helper (add1 i))
                            (helper (add1 i)))))))))))
  (helper 0))