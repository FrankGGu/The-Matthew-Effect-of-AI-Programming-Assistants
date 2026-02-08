(define (number-of-special-chars word)
  (let loop ([i 0] [count 0])
    (cond
      [(= i (string-length word)) count]
      [else
       (let ([c (string-ref word i)])
         (if (and (char-lower-case? c)
                  (string-contains? word (string (char-upcase c))))
             (loop (+ i 1) (+ count 1))
             (loop (+ i 1) count)))])))