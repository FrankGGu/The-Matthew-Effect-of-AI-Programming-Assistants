(define (count-quadruplets nums)
  (let ((n (length nums)))
    (let loop ((i 0) (count 0))
      (if (= i n)
          count
          (loop (+ i 1)
                (let loop2 ((j (+ i 1)) (count2 count))
                  (if (= j n)
                      count2
                      (loop2 (+ j 1)
                             (let loop3 ((k (+ j 1)) (count3 count2))
                               (if (= k n)
                                   count3
                                   (loop3 (+ k 1)
                                          (let loop4 ((l (+ k 1)) (count4 count3))
                                            (if (= l n)
                                                count4
                                                (loop4 (+ l 1)
                                                       (if (= (+ (list-ref nums i) (list-ref nums j) (list-ref nums k)) (list-ref nums l))
                                                           (+ count4 1)
                                                           count4)))))))))))))))