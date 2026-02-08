(define (count-alternating-subarrays nums)
  (let ([n (length nums)])
    (cond
      [(zero? n) 0]
      [else
       (let loop ([lst (cdr nums)]
                  [prev-val (car nums)]
                  [current-alternating-length 1]
                  [total-subarrays 1])
         (if (null? lst)
             total-subarrays
             (let* ([curr-val (car lst)]
                    [new-current-alternating-length (if (!= curr-val prev-val)
                                                        (+ current-alternating-length 1)
                                                        1)])
               (loop (cdr lst)
                     curr-val
                     new-current-alternating-length
                     (+ total-subarrays new-current-alternating-length)))))])))