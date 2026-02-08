(define (unequal-triplets nums)
  (let ([n (length nums)])
    (let loop ([i 0] [count 0])
      (cond
        [(>= i (- n 2)) count]
        [else
         (let loop2 ([j (+ i 1)])
           (cond
             [(>= j (- n 1)) (loop (+ i 1) count)]
             [else
              (let loop3 ([k (+ j 1)])
                (cond
                  [(>= k n) (loop2 (+ j 1))]
                  [else
                   (if (and (not (= (list-ref nums i) (list-ref nums j)))
                            (not (= (list-ref nums i) (list-ref nums k)))
                            (not (= (list-ref nums j) (list-ref nums k))))
                       (loop3 (+ k 1) (+ count 1))
                       (loop3 (+ k 1) count))]))]))])))))