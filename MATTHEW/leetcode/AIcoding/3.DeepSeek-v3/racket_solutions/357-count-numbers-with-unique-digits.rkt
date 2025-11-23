(define (count-numbers-with-unique-digits n)
  (if (= n 0)
      1
      (let loop ([i 1] [res 10] [available 9] [current 9])
        (if (or (> i n) (= available 0))
            res
            (loop (add1 i) 
                  (+ res (* current available)) 
                  (sub1 available) 
                  (* current available))))))