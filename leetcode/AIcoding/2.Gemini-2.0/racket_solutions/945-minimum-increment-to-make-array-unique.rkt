(define (min-increment-for-unique A)
  (let* ([sorted-A (sort A <)]
         [n (length A)])
    (let loop ([i 1]
               [res 0]
               [taken (list (car sorted-A))])
      (if (= i n)
          res
          (let ([current (list-ref sorted-A i)]
                [last (car taken)])
            (if (>= current last)
                (loop (+ i 1) res (cons current taken))
                (let ([increment (+ 1 last)])
                  (loop (+ i 1) (+ res (- increment current)) (cons increment taken)))))))))