(define/contract (max-profit price tickets)
  (-> exact-integer? (listof exact-integer?) exact-integer?)
  (let loop ([i 0] [balance 0] [total 0])
    (if (>= i (length tickets))
        total
        (let* ([ticket (list-ref tickets i)]
               [cost (* ticket price)])
          (if (>= balance cost)
              (loop (+ i 1) (- balance cost) (+ total cost))
              (loop (+ i 1) (+ balance (car tickets)) total))))))