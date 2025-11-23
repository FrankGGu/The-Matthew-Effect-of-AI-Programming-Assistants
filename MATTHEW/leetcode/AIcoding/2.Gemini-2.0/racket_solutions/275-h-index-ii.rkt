(define (h-index citations)
  (let* ([n (length citations)]
         [l 0]
         [r (- n 1)])
    (if (zero? n)
        0
        (let loop ([l l] [r r])
          (if (<= l r)
              (let* ([mid (floor (+ l r) 2)]
                     [h (- n mid)])
                (cond
                  [(>= (list-ref citations mid) h)
                   (loop l (- mid 1))]
                  [else
                   (loop (+ mid 1) r)]))
              (- n l))))))