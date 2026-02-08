(define (alternatingSum nums)
  (define (helper lst index sum)
    (if (null? lst)
        sum
        (helper (cdr lst) (+ index 1) 
                (if (even? index) 
                    (+ sum (car lst)) 
                    (- sum (car lst))))))
  (helper nums 0 0))

(alternatingSum '(1 2 3 4 5))