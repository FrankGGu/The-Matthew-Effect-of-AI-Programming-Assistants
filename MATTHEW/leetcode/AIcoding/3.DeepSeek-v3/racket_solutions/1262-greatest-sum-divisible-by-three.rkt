(define/contract (max-sum-div-three nums)
  (-> (listof exact-integer?) exact-integer?)
  (let loop ([nums nums]
             [rem0 0]
             [rem1 -inf.0]
             [rem2 -inf.0])
    (if (null? nums)
        rem0
        (let* ([num (car nums)]
               [new-rem0 (max rem0
                              (if (= (modulo num 3) 0) (+ rem0 num) -inf.0)
                              (if (= (modulo num 3) 1) (+ rem2 num) -inf.0)
                              (if (= (modulo num 3) 2) (+ rem1 num) -inf.0))]
               [new-rem1 (max rem1
                              (if (= (modulo num 3) 0) (+ rem1 num) -inf.0)
                              (if (= (modulo num 3) 1) (+ rem0 num) -inf.0)
                              (if (= (modulo num 3) 2) (+ rem2 num) -inf.0))]
               [new-rem2 (max rem2
                              (if (= (modulo num 3) 0) (+ rem2 num) -inf.0)
                              (if (= (modulo num 3) 1) (+ rem1 num) -inf.0)
                              (if (= (modulo num 3) 2) (+ rem0 num) -inf.0))])
          (loop (cdr nums) new-rem0 new-rem1 new-rem2)))))