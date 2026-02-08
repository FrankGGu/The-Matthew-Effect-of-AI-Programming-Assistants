(define (partition-disjoint nums)
  (let loop ([i 1]
             [max-left (car nums)]
             [max-so-far (car nums)])
    (if (= i (length nums))
        i
        (let ([curr (list-ref nums i)])
          (if (> curr max-left)
              (loop (+ i 1) max-left (max max-so-far curr))
              (loop (+ i 1) max-so-far (max max-so-far curr)))))))