(define (is-ugly? n)
  (cond
    [(<= n 0) #f]
    [(= n 1) #t]
    [else
     (define (divide-until-not-divisible n d)
       (if (= (remainder n d) 0)
           (divide-until-not-divisible (/ n d) d)
           n))
     (let* ([n2 (divide-until-not-divisible n 2)]
            [n3 (divide-until-not-divisible n2 3)]
            [n5 (divide-until-not-divisible n3 5)])
       (= n5 1))]))