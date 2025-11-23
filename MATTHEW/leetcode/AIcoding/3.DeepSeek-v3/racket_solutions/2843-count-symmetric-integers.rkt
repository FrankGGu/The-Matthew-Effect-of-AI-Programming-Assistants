(define (count-symmetric-integers low high)
  (define (symmetric? num)
    (let* ([s (number->string num)]
           [len (string-length s)])
      (if (even? len)
          (let loop ([i 0] [sum 0])
            (if (< i (/ len 2))
                (loop (+ i 1) (+ sum (- (char->integer (string-ref s i)) 
                                        (char->integer (string-ref s (- len i 1))))))
                (= sum 0)))
          #f)))

  (let loop ([i low] [count 0])
    (if (> i high)
        count
        (loop (+ i 1) (if (symmetric? i) (+ count 1) count)))))