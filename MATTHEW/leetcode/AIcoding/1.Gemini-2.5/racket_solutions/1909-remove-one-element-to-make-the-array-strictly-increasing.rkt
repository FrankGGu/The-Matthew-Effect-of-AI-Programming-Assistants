(define (is-strictly-increasing lst)
  (let ([n (length lst)])
    (let loop ([i 1])
      (cond
        [(= i n) #t]
        [(>= (list-ref lst (sub1 i)) (list-ref lst i)) #f]
        [else (loop (add1 i))]))))

(define (remove-at lst idx)
  (append (take lst idx) (drop lst (add1 idx))))

(define (can-be-strictly-increasing nums)
  (let ([n (length nums)])
    (if (is-strictly-increasing nums)
        #t
        (let loop ([i 0])
          (cond
            [(= i n) #f]
            [else
             (let ([temp-nums (remove-at nums i)])
               (if (is-strictly-increasing temp-nums)
                   #t
                   (loop (add1 i))))])))))