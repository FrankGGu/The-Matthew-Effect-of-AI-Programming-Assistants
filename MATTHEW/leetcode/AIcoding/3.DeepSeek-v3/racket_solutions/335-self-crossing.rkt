(define/contract (is-self-crossing distance)
  (-> (listof exact-integer?) boolean?)
  (let loop ([i 3] [distances distance] [n (length distance)])
    (cond
      [(>= i n) #f]
      [(and (>= i 3)
            (>= (list-ref distances (- i 1)) (list-ref distances (- i 3)))
            (<= (list-ref distances i) (list-ref distances (- i 2))))
       #t]
      [(and (>= i 4)
            (= (list-ref distances (- i 1)) (list-ref distances (- i 3)))
            (>= (+ (list-ref distances i) (list-ref distances (- i 4))) (list-ref distances (- i 2))))
       #t]
      [(and (>= i 5)
            (>= (list-ref distances (- i 2)) (list-ref distances (- i 4)))
            (>= (+ (list-ref distances i) (list-ref distances (- i 4))) (list-ref distances (- i 2)))
            (>= (list-ref distances (- i 1)) (- (list-ref distances (- i 3)) (list-ref distances (- i 5))))
            (<= (list-ref distances (- i 1)) (list-ref distances (- i 3))))
       #t]
      [else (loop (+ i 1) distances n)])))