(define (numRookCaptures board)
  (let loop ([i 0] [j 0] [rook-found? #f])
    (cond
      [(and (= i 8) (not rook-found?)) 0]
      [(and (= i 8) rook-found?) (let ([rook-i (index-i)] [rook-j (index-j)])
                                    (let ([count 0])
                                      (let loop-up ([i (sub1 rook-i)])
                                        (cond
                                          [(< i 0) #f]
                                          [(equal? (list-ref (list-ref board i) rook-j) #\B) #f]
                                          [(equal? (list-ref (list-ref board i) rook-j) #\p) (set! count (add1 count)) #f]
                                          [else (loop-up (sub1 i))]))
                                      (let loop-down ([i (add1 rook-i)])
                                        (cond
                                          [(>= i 8) #f]
                                          [(equal? (list-ref (list-ref board i) rook-j) #\B) #f]
                                          [(equal? (list-ref (list-ref board i) rook-j) #\p) (set! count (add1 count)) #f]
                                          [else (loop-down (add1 i))]))
                                      (let loop-left ([j (sub1 rook-j)])
                                        (cond
                                          [(< j 0) #f]
                                          [(equal? (list-ref (list-ref board rook-i) j) #\B) #f]
                                          [(equal? (list-ref (list-ref board rook-i) j) #\p) (set! count (add1 count)) #f]
                                          [else (loop-left (sub1 j))]))
                                      (let loop-right ([j (add1 rook-j)])
                                        (cond
                                          [(>= j 8) #f]
                                          [(equal? (list-ref (list-ref board rook-i) j) #\B) #f]
                                          [(equal? (list-ref (list-ref board rook-i) j) #\p) (set! count (add1 count)) #f]
                                          [else (loop-right (add1 j))]))
                                      count))]
      [else
       (cond
         [(equal? (list-ref (list-ref board i) j) #\R) (begin (set! index-i i) (set! index-j j) (loop (add1 i) 0 #t))]
         [(= j 7) (loop (add1 i) 0 rook-found?)]
         [else (loop i (add1 j) rook-found?)])])))
  (define index-i 0)
  (define index-j 0))