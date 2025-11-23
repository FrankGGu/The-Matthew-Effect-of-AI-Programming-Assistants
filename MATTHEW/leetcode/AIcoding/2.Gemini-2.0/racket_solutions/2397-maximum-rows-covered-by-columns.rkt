(define (maximum-rows-covered matrix num-select)
  (define m (length matrix))
  (define n (length (car matrix)))

  (define (covered? mask row)
    (let loop ([i 0])
      (cond [(>= i n) #t]
            [(= (list-ref row i) 1)
             (if (bitwise-bit-set? mask i)
                 (loop (+ i 1))
                 #f)]
            [else (loop (+ i 1))])))

  (define (count-covered mask)
    (let loop ([i 0] [count 0])
      (cond [(>= i m) count]
            [(covered? mask (list-ref matrix i))
             (loop (+ i 1) (+ count 1))]
            [else (loop (+ i 1) count)])))

  (define (generate-masks k current-mask current-index)
    (cond [(zero? k) (list current-mask)]
          [(>= current-index n) '()]
          [else (append (generate-masks k current-mask (+ current-index 1))
                        (generate-masks (- k 1) (bitwise-ior current-mask (arithmetic-shift 1 current-index)) (+ current-index 1)))]))

  (define masks (generate-masks num-select 0 0))
  (apply max (map count-covered masks)))