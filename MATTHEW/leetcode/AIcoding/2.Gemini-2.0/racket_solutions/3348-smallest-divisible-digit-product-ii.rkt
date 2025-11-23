(define (smallest-divisible-digit-product n)
  (define (find-digits n)
    (cond
      [(< n 10) (list n)]
      [(= (remainder n 2) 0) (cons 2 (find-digits (/ n 2)))]
      [(= (remainder n 3) 0) (cons 3 (find-digits (/ n 3)))]
      [(= (remainder n 5) 0) (cons 5 (find-digits (/ n 5)))]
      [(= (remainder n 7) 0) (cons 7 (find-digits (/ n 7)))]
      [else (list)]))

  (cond
    [(= n 1) 1]
    [(= n 0) 10]
    [else
     (let* ([digits (sort (find-digits n) <)]
            [len (length digits)])
       (if (= len 0)
           -1
           (list->string (map (λ (x) (integer->char (+ x 48))) digits))))]))