(define (maxMoney amount)
  (let loop ((i 0) (prev 0) (curr 0))
    (if (>= i (length amount))
        curr
        (loop (+ i 1) curr (max curr (+ prev (list-ref amount i)))))))

(define (rob amount)
  (maxMoney amount))