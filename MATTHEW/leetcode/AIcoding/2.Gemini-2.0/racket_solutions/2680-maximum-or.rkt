(define (maximum-or nums k)
  (define (max-or nums idx current-or shifts)
    (cond
      [(empty? nums) current-or]
      [else
       (let* ([first-num (car nums)]
              [rest-nums (cdr nums)]
              [shifted-num (* first-num (expt 2 k))]
              [or1 (max-or rest-nums idx (bitwise-ior current-or shifted-num) shifts)]
              [or2 (max-or rest-nums (+ idx 1) (bitwise-ior current-or first-num) shifts)])
         (max or1 or2))]))
  (max-or nums 0 0 k))