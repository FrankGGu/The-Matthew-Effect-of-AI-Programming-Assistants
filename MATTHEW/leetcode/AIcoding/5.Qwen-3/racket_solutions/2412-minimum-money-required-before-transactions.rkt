(define/contract (minimum-money transactions)
  (-> (listof (cons/c exact-integer? exact-integer?)) exact-integer?)
  (let loop ([transactions transactions] [balance 0])
    (if (null? transactions)
        balance
        (let* ([t (car transactions)]
               [cash (car t)]
               [cost (cdr t)])
          (if (>= balance cost)
              (loop (cdr transactions) (- balance cost))
              (loop (cdr transactions) (+ balance (- cost cash))))))))