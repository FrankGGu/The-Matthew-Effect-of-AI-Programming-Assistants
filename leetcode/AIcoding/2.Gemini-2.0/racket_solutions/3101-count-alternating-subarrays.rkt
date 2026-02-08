(define (count-alternating-subarrays nums)
  (let* ([n (length nums)]
         [count (box 0)])
    (for ([i (in-range n)])
      (for ([j (in-range i n)])
        (let ([sub-array (list-tail nums i)])
          (let ([sub-array (list-take sub-array (- j i 1))])
            (let ([is-alternating (let loop ([lst sub-array])
                                    (cond
                                      [(null? lst) #t]
                                      [(null? (cdr lst)) #t]
                                      [else (if (= (sgn (car lst) (cadr lst)) 1)
                                                (loop (cdr lst))
                                                #f)]))])
              (when is-alternating
                (set-box! count (+ (unbox count) 1))))))))
    (unbox count)))

(define (sgn x y)
  (cond
    [(> x y) 1]
    [else 0]))