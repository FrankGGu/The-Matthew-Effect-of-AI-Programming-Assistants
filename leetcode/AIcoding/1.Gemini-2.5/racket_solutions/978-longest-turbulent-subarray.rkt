(define (longest-turbulent-subarray arr)
  (define n (length arr))
  (cond
    [(zero? n) 0]
    [(= n 1) 1]
    [else
     (let recur ((rest-arr (cdr arr))
                 (prev-val (car arr))
                 (inc-len 1) ; length of turbulent subarray ending with an increasing pair
                 (dec-len 1) ; length of turbulent subarray ending with a decreasing pair
                 (max-len 1))
       (if (null? rest-arr)
           max-len
           (let* ((curr-val (car rest-arr))
                  (new-inc-len
                   (cond
                     ((> curr-val prev-val) (+ dec-len 1))
                     ((< curr-val prev-val) 1)
                     (else 1)))
                  (new-dec-len
                   (cond
                     ((< curr-val prev-val) (+ inc-len 1))
                     ((> curr-val prev-val) 1)
                     (else 1))))
             (recur (cdr rest-arr)
                    curr-val
                    new-inc-len
                    new-dec-len
                    (max max-len new-inc-len new-dec-len)))))]))