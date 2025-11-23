(define (find-peak-element nums)
  (let* ([n (vector-length nums)]
         [left 0]
         [right (- n 1)])
    (let loop ([l left] [r right])
      (if (< l r)
          (let ([mid (+ l (quotient (- r l) 2))])
            (if (> (vector-ref nums mid) (vector-ref nums (+ mid 1)))
                (loop l mid)
                (loop (+ mid 1) r)))
          l))))