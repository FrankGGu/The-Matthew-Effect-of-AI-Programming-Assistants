(define (maximumANDSum nums numSlots)
  (define n (length nums))
  (define (dp mask slot)
    (cond
      [(= mask (expt 2 n)) 0]
      [else
       (let loop ([i 0] [max-sum 0])
         (cond
           [(= i n) max-sum]
           [(= (bitwise-and mask (expt 2 i)) 0)
            (let ([new-mask (bitwise-ior mask (expt 2 i))])
              (loop (+ i 1) (max max-sum (+ (bitwise-and (list-ref nums i) slot) (dp new-mask slot)))))
           [else (loop (+ i 1) max-sum)]))]))
  (define (solve slot)
    (if (= slot 0)
        0
        (let ([res (dp 0 slot)])
          (max res (solve (- slot 1))))))
  (solve numSlots))