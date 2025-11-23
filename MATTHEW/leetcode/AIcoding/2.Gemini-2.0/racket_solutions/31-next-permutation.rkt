(define (next-permutation nums)
  (define n (length nums))
  (define (swap! i j)
    (define temp (list-ref nums i))
    (list-set! nums i (list-ref nums j))
    (list-set! nums j temp))
  (define (reverse! start end)
    (let loop ([i start] [j end])
      (cond
        [(>= i j) #t]
        [else (swap! i j)
              (loop (+ i 1) (- j 1))])))

  (let loop ([i (- n 2)])
    (cond
      [(= i -1) (reverse! 0 (- n 1))]
      [(< (list-ref nums i) (list-ref nums (+ i 1)))
       (let find-j-loop ([j (- n 1)])
         (cond
           [(<= (list-ref nums i) (list-ref nums j))
            (find-j-loop (- j 1))]
           [else
            (swap! i j)
            (reverse! (+ i 1) (- n 1))
            #t]))
       #t]
      [else (loop (- i 1))]))
  nums)