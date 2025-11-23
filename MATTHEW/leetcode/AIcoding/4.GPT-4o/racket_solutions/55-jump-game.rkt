(define (can-jump nums)
  (define (jump-helper index max-reach)
    (if (>= index (length nums))
        #f
        (if (>= index max-reach)
            #f
            (if (= index (sub1 (length nums)))
                #t
                (jump-helper (add1 index) (max max-reach (+ index (list-ref nums index))))))))
  (jump-helper 0 0))