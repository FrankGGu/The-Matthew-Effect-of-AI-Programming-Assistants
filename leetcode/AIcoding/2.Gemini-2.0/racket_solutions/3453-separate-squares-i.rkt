(define (separate-squares n)
  (cond
    [(<= n 0) #f]
    [(= n 1) #t]
    [else
     (let loop ([a 1])
       (cond
         [(> a (sqrt n)) #f]
         [(= (+ (* a a) (* a a)) n) #t]
         [(let loop2 ([b a])
            (cond
              [(> b (sqrt n)) #f]
              [(= (+ (* a a) (* b b)) n) #t]
              [else (loop2 (+ b 1))])) #t]
         [else (loop (+ a 1))]))]))