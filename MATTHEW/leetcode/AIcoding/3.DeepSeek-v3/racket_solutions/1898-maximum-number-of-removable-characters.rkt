(define/contract (maximum-removals s p removable)
  (-> string? string? (listof exact-integer?) exact-integer?)
  (let loop ([left 0]
             [right (length removable)])
    (if (> left right)
        left
        (let* ([mid (quotient (+ left right) 2)]
               [removed (take removable mid)]
               [s-array (string->list s)]
               [marked (for/hash ([i removed]) (values i #t))]
               [new-s (list->string (for/list ([c s-array] [i (in-naturals)] 
                                              (if (hash-ref marked i #f) #\NUL c)))]
               [is-subseq? (let ([i 0] [j 0])
                             (let loop ()
                               (cond
                                 [(= j (string-length p)) #t]
                                 [(>= i (string-length new-s)) #f]
                                 [(char=? (string-ref new-s i) (string-ref p j)) (loop (add1 i) (add1 j))]
                                 [else (loop (add1 i) j)])))])
          (if is-subseq?
              (loop (add1 mid) right)
              (loop left (sub1 mid))))))