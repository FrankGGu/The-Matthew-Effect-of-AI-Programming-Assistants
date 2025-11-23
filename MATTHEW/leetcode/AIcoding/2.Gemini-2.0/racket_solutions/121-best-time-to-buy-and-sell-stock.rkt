(define (max-profit prices)
  (let loop ([i 1] [min-price (car prices)] [max-so-far 0])
    (if (null? (cdr (drop prices (- i 1))))
        max-so-far
        (let* ([current-price (list-ref prices i)]
               [current-profit (- current-price min-price)])
          (loop (+ i 1)
                (min min-price current-price)
                (max max-so-far current-profit))))))