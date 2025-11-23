(define (can-place-flowers flowerbed n)
  (let loop ([i 0] [count 0] [bed flowerbed])
    (cond
      [(>= count n) #t]
      [(>= i (length bed)) #f]
      [(and (zero? (list-ref bed i))
            (or (zero? i) (zero? (list-ref bed (- i 1))))
            (or (= i (- (length bed) 1)) (zero? (list-ref bed (+ i 1)))))
       (loop (+ i 2) (+ count 1) (list-set bed i 1))]
      [else (loop (+ i 1) count bed)])))