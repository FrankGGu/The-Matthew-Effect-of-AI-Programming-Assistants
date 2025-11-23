(define/contract (max-value-after-reverse nums)
  (-> (listof exact-integer?) exact-integer?)
  (let* ([n (length nums)]
         [original-value (for/sum ([i (in-range (- n 1))])
                          (abs (- (list-ref nums i) (list-ref nums (+ i 1)))))]
         [max-diff1 (for/fold ([max-d 0])
                              ([i (in-range 1 n)])
                      (max max-d (- (abs (- (list-ref nums 0) (list-ref nums i)))
                                    (abs (- (list-ref nums i) (list-ref nums (- i 1)))))))]
         [max-diff2 (for/fold ([max-d 0])
                              ([i (in-range (- n 1))])
                      (max max-d (- (abs (- (list-ref nums (- n 1)) (list-ref nums i)))
                                    (abs (- (list-ref nums (+ i 1)) (list-ref nums i))))))]
         [max-diff3 (for/fold ([max-d 0])
                              ([i (in-range 1 n)])
                      (for/fold ([current-max max-d])
                                ([j (in-range i)])
                        (max current-max
                             (- (+ (abs (- (list-ref nums j) (list-ref nums i)))
                                 (if (< (+ j 1) i) (abs (- (list-ref nums (+ j 1)) (list-ref nums i))) 0)
                                 (+ (abs (- (list-ref nums j) (list-ref nums (+ j 1))))
                                 (if (> i (+ j 1)) (abs (- (list-ref nums i) (list-ref nums (+ j 1)))) 0))))))]
         [max-diff (max max-diff1 max-diff2 max-diff3)])
    (+ original-value max-diff)))