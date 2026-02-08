(define (can-move-pieces start target)
  (if (not (= (string-length start) (string-length target)))
      #f
      (begin
        (let ([filtered-start (list->string (filter (lambda (c) (not (char=? c #\X))) (string->list start)))]
              [filtered-target (list->string (filter (lambda (c) (not (char=? c #\X))) (string->list target)))])
          (if (not (string=? filtered-start filtered-target))
              #f
              (let loop ([i 0] [j 0])
                (let* ([next-i (let skip-i ([k i])
                                  (if (and (< k (string-length start)) (char=? (string-ref start k) #\X))
                                      (skip-i (+ k 1))
                                      k))]
                       [next-j (let skip-j ([k j])
                                  (if (and (< k (string-length target)) (char=? (string-ref target k) #\X))
                                      (skip-j (+ k 1))
                                      k))])
                  (cond
                    [(and (= next-i (string-length start)) (= next-j (string-length target))) #t]
                    [(or (= next-i (string-length start)) (= next-j (string-length target))) #f]
                    [else
                      (let ([si (string-ref start next-i)]
                            [tj (string-ref target next-j)])
                        (cond
                          [(char=? si #\L)
                            (if (<= next-j next-i)
                                (loop (+ next-i 1) (+ next-j 1))
                                #f)]
                          [(char=? si #\R)
                            (if (>= next-j next-i)
                                (loop (+ next-i 1) (+ next-j 1))
                                #f)]
                          [else #f]))]))))))))