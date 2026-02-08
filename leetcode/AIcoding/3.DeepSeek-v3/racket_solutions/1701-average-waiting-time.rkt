(define/contract (average-waiting-time customers)
  (-> (listof (listof exact-integer?)) flonum?)
  (let loop ([customers customers]
             [current-time 0]
             [total-waiting 0]
             [count 0])
    (if (null? customers)
        (/ total-waiting count 1.0)
        (let* ([customer (car customers)]
               [arrival (car customer)]
               [prep-time (cadr customer)]
               [start-time (max current-time arrival)]
               [end-time (+ start-time prep-time)]
               [waiting-time (- end-time arrival)])
          (loop (cdr customers)
                end-time
                (+ total-waiting waiting-time)
                (+ count 1))))))