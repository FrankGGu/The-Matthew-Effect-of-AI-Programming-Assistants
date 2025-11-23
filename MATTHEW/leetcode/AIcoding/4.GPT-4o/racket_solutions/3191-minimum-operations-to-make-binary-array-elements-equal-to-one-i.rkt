(define (minOperations nums)
  (define n (length nums))
  (define count (apply + nums))
  (if (zero? count)
      n
      (let loop ((i 0) (ops 0))
        (if (= i n)
            ops
            (loop (+ i 1) 
                  (if (= (list-ref nums i) 0)
                      (+ ops 1)
                      ops))))))