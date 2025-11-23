(define (utf8-validation data)
  (let* ([n (length data)]
         [data-vec (list->vector data)])
    (let loop ([i 0] [remaining-bytes 0])
      (cond
        [(= i n)
         (= remaining-bytes 0)]
        [(= remaining-bytes 0)
         (let ([byte (vector-ref data-vec i)])
           (cond
             [(= (bitwise-and byte #b10000000) #b00000000)
              (loop (+ i 1) 0)]
             [(= (bitwise-and byte #b11100000) #b11000000)
              (loop (+ i 1) 1)]
             [(= (bitwise-and byte #b11110000) #b11100000)
              (loop (+ i 1) 2)]
             [(= (bitwise-and byte #b11111000) #b11110000)
              (loop (+ i 1) 3)]
             [else
              #f]))]
        [else
         (let ([byte (vector-ref data-vec i)])
           (if (= (bitwise-and byte #b11000000) #b10000000)
               (loop (+ i 1) (- remaining-bytes 1))
               #f))]))))