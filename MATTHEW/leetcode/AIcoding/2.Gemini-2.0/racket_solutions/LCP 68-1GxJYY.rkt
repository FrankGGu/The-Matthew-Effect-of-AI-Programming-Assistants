(define (is-valid-bouquet bouquet max-adjacent)
  (cond
    [(empty? bouquet) #t]
    [(empty? (cdr bouquet)) #t]
    [else
     (let loop ([lst (cdr bouquet)]
                [prev (car bouquet)]
                [count 1])
       (cond
         [(empty? lst) #t]
         [else
          (let ([curr (car lst)])
            (cond
              [(= curr prev)
               (cond
                 [(>= (add1 count) max-adjacent) #f]
                 [else (loop (cdr lst) curr (add1 count))])]
              [else (loop (cdr lst) curr 1)]))]))]))

(define (min-days bouquet m max-adjacent)
  (let ([left 1]
        [right (apply max bouquet)])
    (let loop ([l left]
               [r right])
      (cond
        [(> l r) -1]
        [else
         (let ([mid (floor (/ (+ l r) 2))])
           (let ([new-bouquet (map (lambda (x) (min x mid)) bouquet)])
             (if (is-valid-bouquet new-bouquet max-adjacent)
                 (let ([ans mid])
                   (let loop2 ([ll left]
                               [rr (sub1 mid)])
                     (cond
                       [(> ll rr) ans]
                       [else
                        (let ([mid2 (floor (/ (+ ll rr) 2))])
                          (let ([new-bouquet2 (map (lambda (x) (min x mid2)) bouquet)])
                            (if (is-valid-bouquet new-bouquet2 max-adjacent)
                                (loop2 ll (sub1 mid2))
                                (loop2 (add1 mid2) rr)))))))
                 (loop (add1 mid) r)))))))))