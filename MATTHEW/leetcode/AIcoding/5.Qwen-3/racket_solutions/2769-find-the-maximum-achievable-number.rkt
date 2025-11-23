(define (max-achievable-number target)
  (let loop ([n 0])
    (if (= (remainder (+ n target) 2) 0)
        n
        (loop (+ n 1)))))