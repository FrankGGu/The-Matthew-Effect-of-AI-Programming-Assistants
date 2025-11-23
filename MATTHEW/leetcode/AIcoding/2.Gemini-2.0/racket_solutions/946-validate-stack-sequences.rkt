(define (validate-stack-sequences pushed popped)
  (let loop ([stack '()] [i 0] [j 0])
    (cond
      [(and (= i (length pushed)) (= j (length popped))) #t]
      [(and (= i (length pushed)) (not (empty? stack))) #f]
      [(and (not (empty? stack)) (= (car stack) (list-ref popped j)))
       (loop (cdr stack) i (+ j 1))]
      [(= i (length pushed)) #f]
      [else
       (loop (cons (list-ref pushed i) stack) (+ i 1) j)])))