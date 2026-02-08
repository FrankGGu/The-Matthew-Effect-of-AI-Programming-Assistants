(define/contract (eliminate-maximum dist speed)
  (-> (listof exact-integer?) (listof exact-integer?) exact-integer?)
  (let* ([n (length dist)]
         [times (for/list ([d dist] [s speed])
                  (ceiling (/ d s))])
    (sort times <)
    (let loop ([time 0] [killed 0] [times times])
      (cond
        [(or (null? times) (<= (car times) time)) killed]
        [else (loop (add1 time) (add1 killed) (cdr times))]))))