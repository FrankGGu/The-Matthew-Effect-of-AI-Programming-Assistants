#lang racket

(define (find-maximum-length-of-valid-subsequence-ii nums k)
  (let ([dp (make-hash)])
    (let ([overall-max-len 0])
      (for ([num (in-list nums)])
        (let ([current-len 1])
          ;; Condition 1: s[i+1] - s[i] == k  =>  s[i] = num - k
          (let ([prev-val-k (- num k)])
            (when (> prev-val-k 0) ; Previous value must be positive
              (when (hash-has-key? dp prev-val-k)
                (set! current-len (max current-len (+ (hash-ref dp prev-val-k) 1))))))

          ;; Condition 2: s[i+1] % s[i] == 0  =>  s[i] is a divisor of num
          (let ([limit (floor (sqrt num))])
            (for ([d (in-range 1 (add1 limit))])
              (when (= (remainder num d) 0)
                ;; Check d as a potential previous value
                (when (hash-has-key? dp d)
                  (set! current-len (max current-len (+ (hash-ref dp d) 1))))

                ;; Check num/d as a potential previous value (if different from d)
                (let ([d2 (/ num d)])
                  (when (and (not (= d d2)) (hash-has-key? dp d2))
                    (set! current-len (max current-len (+ (hash-ref dp d2) 1))))))))

          ;; Update dp for the current num
          ;; Take the max of existing length for 'num' or the newly calculated 'current-len'
          (hash-set! dp num (max (hash-ref dp num 0) current-len))

          ;; Update overall maximum length
          (set! overall-max-len (max overall-max-len (hash-ref dp num))))
      overall-max-len)))