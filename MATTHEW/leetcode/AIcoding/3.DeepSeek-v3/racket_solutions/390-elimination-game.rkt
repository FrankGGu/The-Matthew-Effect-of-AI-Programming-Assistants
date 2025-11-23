(define (last-remaining n)
  (let loop ([n n] [left? #t] [step 1] [head 1])
    (if (= n 1)
        head
        (if (or left? (odd? n))
            (loop (quotient n 2) (not left?) (* step 2) (+ head step))
            (loop (quotient n 2) (not left?) (* step 2) head)))))