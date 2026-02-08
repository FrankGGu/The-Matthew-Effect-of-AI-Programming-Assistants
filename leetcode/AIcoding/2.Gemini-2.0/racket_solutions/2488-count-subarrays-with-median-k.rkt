(define (count-subarrays-with-median-k nums k)
  (let* ([n (length nums)]
         [prefix-sums (make-vector (+ n 1) 0)])
    (let loop ([i 0] [count 0])
      (if (= i n)
          count
          (let* ([sign (if (> (list-ref nums i) k) 1 (if (< (list-ref nums i) k) -1 0))]
                 [_ (vector-set! prefix-sums (+ i 1) (+ (vector-ref prefix-sums i) sign))]
                 [j 0])
            (let inner-loop ([j 0] [inner-count count])
              (if (= j (+ i 1))
                  (loop (+ i 1) inner-count)
                  (let ([diff (- (vector-ref prefix-sums (+ i 1)) (vector-ref prefix-sums j))])
                    (inner-loop (+ j 1) (+ inner-count (if (or (= diff 0) (= diff 1)) 1 0)))))))))))