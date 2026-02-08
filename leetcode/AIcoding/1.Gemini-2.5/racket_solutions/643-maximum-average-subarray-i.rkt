(define (find-max-average nums k)
  (let* ([n (length nums)]
         [nums-vec (list->vector nums)])
    (let ([initial-sum (for/sum ([i (in-range k)])
                         (vector-ref nums-vec i))])
      (let loop ([i k]
                 [current-sum initial-sum]
                 [max-sum initial-sum])
        (if (= i n)
            (/ (exact->inexact max-sum) k)
            (let* ([new-sum (+ (- current-sum (vector-ref nums-vec (- i k)))
                               (vector-ref nums-vec i))]
                   [new-max-sum (max max-sum new-sum)])
              (loop (+ i 1) new-sum new-max-sum)))))))