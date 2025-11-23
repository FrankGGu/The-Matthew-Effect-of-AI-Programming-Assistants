(define (threeConsecutiveOdds arr)
  (define (count-odds lst)
    (length (filter odd? lst)))
  (define (helper lst)
    (if (null? lst)
        #f
        (if (= (count-odds (take lst 3)) 3)
            #t
            (helper (cdr lst)))))
  (helper arr))