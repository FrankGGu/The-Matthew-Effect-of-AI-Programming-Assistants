(define (count-pairs points k)
  (let* [(n (length points))
         (count (box 0))]
    (for* ([i (range 0 n)]
           [j (range (+ i 1) n)])
      (let ([x1 (first (list-ref points i))]
            [y1 (second (list-ref points i))]
            [x2 (first (list-ref points j))]
            [y2 (second (list-ref points j))])
        (when (= (+ (bitwise-xor x1 x2) (bitwise-xor y1 y2)) k)
          (set-box! count (+ (unbox count) 1)))))
    (unbox count)))