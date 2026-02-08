(define (maximum-coins-from-k-consecutive-bags bags k)
  (let* ((n (length bags)))
    (cond
      ((= k 0) 0)
      ((< n k) 0)
      (else
       (let* ((bags-vec (list->vector bags))
              (initial-sum (for/sum ((j (in-range k))) (vector-ref bags-vec j))))
         (let loop ((i k)
                    (current-sum initial-sum)
                    (max-sum initial-sum))
           (if (= i n)
               max-sum
               (let* ((new-sum (+ (- current-sum (vector-ref bags-vec (- i k)))
                                  (vector-ref bags-vec i)))
                      (new-max-sum (max max-sum new-sum)))
                 (loop (+ i 1) new-sum new-max-sum)))))))))