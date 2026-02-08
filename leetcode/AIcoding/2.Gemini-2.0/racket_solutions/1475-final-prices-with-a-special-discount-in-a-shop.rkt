(define (final-prices prices)
  (let loop ([i 0] [result '()])
    (if (= i (length prices))
        (reverse result)
        (let ([discount (let loop2 ([j (+ i 1)])
                           (if (= j (length prices))
                                0
                               (if (<= (list-ref prices j) (list-ref prices i))
                                   (list-ref prices j)
                                   (loop2 (+ j 1)))))]
              [new-price (- (list-ref prices i) discount)])
          (loop (+ i 1) (cons new-price result))))))