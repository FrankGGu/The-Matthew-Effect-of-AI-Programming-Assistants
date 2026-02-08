(define (can-complete-circuit gas cost)
  (let ((n (length gas)))
    (let loop ((start 0))
      (if (= start n)
          #f
          (let loop2 ((i start) (current-gas 0))
            (cond
              ((= i (+ start n)) #t)
              ((< (+ current-gas (list-ref gas (remainder i n))) (list-ref cost (remainder i n)))
               (loop (+ start 1)))
              (else
               (loop2 (+ i 1) (- (+ current-gas (list-ref gas (remainder i n))) (list-ref cost (remainder i n)))))))))
    (let loop3 ((i 0))
      (cond
        ((= i n) -1)
        ((can-complete-circuit gas cost i) i)
        (else (loop3 (+ i 1)))))))