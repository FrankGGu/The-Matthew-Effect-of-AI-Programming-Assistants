(define (pivot-index nums)
  (let* ([n (length nums)]
         [nums-vec (list->vector nums)]
         [total-sum (for/fold ([s 0])
                               ([x nums])
                     (+ s x))])
    (let loop ([i 0] [left-sum 0])
      (cond
        [(= i n) -1]
        [else
         (let* ([current-num (vector-ref nums-vec i)]
                [right-sum (- total-sum left-sum current-num)])
           (if (= left-sum right-sum)
               i
               (loop (+ i 1) (+ left-sum current-num))))]))))