(define/contract (divide-players skill)
  (-> (listof exact-integer?) exact-integer?)
  (let* ([n (length skill)]
         [total (apply + skill)]
         [target (/ total (/ n 2))])
    (if (not (integer? target))
        -1
        (let ([skill-sorted (sort skill <)]
              [res 0])
          (let loop ([left 0]
                     [right (sub1 n)])
            (if (>= left right)
                res
                (let ([sum (+ (list-ref skill-sorted left)
                              (list-ref skill-sorted right))])
                  (if (= sum target)
                      (loop (add1 left)
                            (sub1 right)
                            (+ res (* (list-ref skill-sorted left)
                                      (list-ref skill-sorted right)))))
                      -1))))))))