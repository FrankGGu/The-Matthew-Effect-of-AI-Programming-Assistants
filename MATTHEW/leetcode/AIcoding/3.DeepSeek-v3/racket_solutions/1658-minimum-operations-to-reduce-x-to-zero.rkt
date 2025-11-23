(define/contract (min-operations nums x)
  (-> (listof exact-integer?) exact-integer? exact-integer?)
  (let* ([total (apply + nums)]
         [target (- total x)]
         [n (length nums)])
    (if (negative? target)
        -1
        (if (zero? target)
            n
            (let loop ([left 0] [current 0] [max-len -1])
              (if (>= left n)
                  (if (= max-len -1) -1 (- n max-len))
                  (let ([right left])
                    (let inner-loop ([right right] [current current])
                      (if (or (>= right n) (> current target))
                          (loop (+ left 1) (- current (list-ref nums left)) max-len)
                          (let ([new-current (+ current (list-ref nums right))])
                            (if (= new-current target)
                                (let ([new-len (- (+ right 1) left)])
                                  (if (> new-len max-len)
                                      (inner-loop (+ right 1) new-current new-len)
                                      (inner-loop (+ right 1) new-current max-len)))
                                (inner-loop (+ right 1) new-current max-len)))))))))))