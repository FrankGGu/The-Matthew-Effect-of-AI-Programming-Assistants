(define (find-length-of-LCIS nums)
  (let ([n (length nums)])
    (if (= n 0)
        0
        (let loop ([i 1] [len 1] [max-len 1])
          (if (= i n)
              max-len
              (if (> (list-ref nums i) (list-ref nums (- i 1)))
                  (loop (+ i 1) (+ len 1) (max max-len (+ len 1)))
                  (loop (+ i 1) 1 max-len)))))))