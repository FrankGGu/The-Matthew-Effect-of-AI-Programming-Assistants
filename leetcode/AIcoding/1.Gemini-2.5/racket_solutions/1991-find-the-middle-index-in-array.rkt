(define (find-middle-index nums)
  (let* ([n (vector-length nums)]
         [total-sum (for/sum ([x nums]) x)])
    (let loop ([i 0] [left-sum 0])
      (cond
        [(= i n) -1]
        [else
         (let ([right-sum (- total-sum left-sum (vector-ref nums i))])
           (if (= left-sum right-sum)
               i
               (loop (+ i 1) (+ left-sum (vector-ref nums i)))))]))))