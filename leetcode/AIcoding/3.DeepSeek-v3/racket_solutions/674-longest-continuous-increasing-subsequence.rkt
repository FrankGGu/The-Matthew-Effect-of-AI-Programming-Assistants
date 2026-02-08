(define/contract (find-length-of-lcis nums)
  (-> (listof exact-integer?) exact-integer?)
  (if (null? nums)
      0
      (let loop ([prev (car nums)] [rest (cdr nums)] [current 1] [max-len 1])
        (cond
          [(null? rest) max-len]
          [(> (car rest) prev)
           (let ([new-current (add1 current)])
             (loop (car rest) (cdr rest) new-current (max max-len new-current)))]
          [else
           (loop (car rest) (cdr rest) 1 (max max-len 1))]))))