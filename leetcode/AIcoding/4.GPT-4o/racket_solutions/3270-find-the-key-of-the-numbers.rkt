(define (findKey numbers key)
  (define (helper nums k)
    (if (null? nums)
        #f
        (if (= (car nums) k)
            #t
            (helper (cdr nums) k))))
  (helper numbers key))