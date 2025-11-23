(define (contains-nearby-almost-duplicate nums k t)
  (define (helper nums k t i)
    (cond
      [(empty? nums) #f]
      [else
       (let loop ([j 0])
         (cond
           [(> j k) #f]
           [(= j (length nums)) #f]
           [(= j i) (loop (+ j 1))]
           [(<= (abs (- (list-ref nums i) (list-ref nums j))) t) #t]
           [else (loop (+ j 1))]))]))
  (let loop ([i 0])
    (cond
      [(>= i (length nums)) #f]
      [(helper nums k t i) #t]
      [else (loop (+ i 1))])))